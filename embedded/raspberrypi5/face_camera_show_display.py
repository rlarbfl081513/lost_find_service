import cv2
import os
import time
import json
import glob
import threading
import requests
import numpy as np
from queue import Queue, Empty, Full
from websocket import WebSocketApp
from PIL import Image, ImageDraw, ImageFont
import serial

# ----------- 설정값 -----------
cameraSource = None                    # 카메라 디바이스 번호
cameraDevice = "/dev/video0"           # usb 카메라
yogiImage = "image.png"                # 요기 사진
screenWidth = 800
screenHeight = 480                     # 화면 크기 설정
wesocketURL = "ws://i13a105.p.ssafy.io:8000/ws/raspberry01"           # 웹소켓 주소
uploadURL = "https://www.yo9i.store/api/v1/upload/upload_selfie"       # 업로드 주소
koreanFont = [
  "/usr/share/fonts/truetype/nanum/NanumGothic.ttf",
  "/usr/share/fonts/truetype/noto/NotoSansCJK-Regular.ttc",
  "/usr/share/fonts/truetype/unfonts-core/UnDotum.ttf",
]           # 한글 폰트 관련

# ----------- 아두이노(시리얼) 설정 -----------
serialPort = "/dev/ttyACM0"    # 아두이노 포트
serialBaud = 9600              # 아두이노 보드레이트
ser = None
serialLock = threading.Lock()

def initSerial():              # 시리얼 연결 초기화
  global ser
  try:
    ser = serial.Serial(serialPort, serialBaud, timeout=1)
    time.sleep(2)
    print(f"[Serial] Opened {serialPort} @ {serialBaud}")
  except Exception as e:
    ser = None
    print("[Serial] 초기화 실패:", e)

def sendArduino(byte_data: bytes):     # 아두이노로 신호 보내기
  if ser is None:
    print("[Serial] 포트가 열려있지 않음")
    return False
  try:
    with serialLock:
      ser.write(byte_data)
      ser.flush()
    print(f"[Serial] 보냄: {byte_data!r}")
    return True
  except Exception as e:
    print("[Serial] 전송 실패:", e)
    return False

# ----------- 제어 플래그 / 상태 -----------
cameraLock = threading.Lock()
stopProgram = threading.Event()
liveStream = threading.Event()

# 현재 요청 컨텍스트
currentID = None
currentUser = "testuser"

# ----------- 디스플레이(메인스레드 전용) -----------
previewName = "Preview"
displayReady = False
displayQueue = Queue(maxsize=2)

def initDisplay(fullscreen=True):           # 디스플레이 설정 초기화
  global displayReady
  if not displayReady:
    cv2.namedWindow(previewName, cv2.WINDOW_NORMAL)
    if fullscreen:
      cv2.setWindowProperty(previewName, cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_FULLSCREEN)
    else:
      cv2.resizeWindow(previewName, screenWidth, screenHeight)
    displayReady = True

def enqueueFrame(frame):                    # 디스플레이 큐에 프레임 넣기
  try:
    displayQueue.put_nowait(frame)
  except Full:
    try:
      _ = displayQueue.get_nowait()
    except Empty:
      pass
    displayQueue.put_nowait(frame)

def showFrame(frame):                       # 디스플레이로 보여주기
  enqueueFrame(frame)

def showYogi():                             # 요기 보여주기
  if os.path.exists(yogiImage):
    img = cv2.imread(yogiImage)
    frame = cv2.resize(img, (screenWidth, screenHeight)) if img is not None else np.zeros((screenHeight, screenWidth, 3), dtype=np.uint8)
  else:
    frame = np.zeros((screenHeight, screenWidth, 3), dtype=np.uint8)
  showFrame(frame)

# ----------------- 카메라 자동 탐색 (한 번만 사용) -----------------
def cameraUsable(dev, width=800, height=480):
  cap = cv2.VideoCapture(dev, cv2.CAP_V4L2)
  if not cap.isOpened():
    return False
  cap.set(cv2.CAP_PROP_FRAME_WIDTH,  width)
  cap.set(cv2.CAP_PROP_FRAME_HEIGHT, height)
  ret, frame = cap.read()
  cap.release()
  return bool(ret) and frame is not None

def findCamera():
  # 1) /dev/v4l/by-id/* 우선(안정적 링크)
  idLink = sorted(glob.glob("/dev/v4l/by-id/*"))
  for link in idLink:
    dev = os.path.realpath(link)
    if cameraUsable(dev, screenWidth, screenHeight):
      print(f"[카메라] by-id 선택: {link} -> {dev}")
      return dev

  # 2) /dev/video* 스캔
  for dev in sorted(glob.glob("/dev/video[0-9]*")):
    if cameraUsable(dev, screenWidth, screenHeight):
      print(f"[카메라] 사용 가능: {dev}")
      return dev

  # 3) 인덱스 스캔
  for idx in range(10):
    if cameraUsable(idx, screenWidth, screenHeight):
      print(f"[카메라] 인덱스 선택: {idx}")
      return idx

  raise RuntimeError("열 수 있는 카메라가 없습니다.")

# ----------------- 텍스트 표시 -----------------
def koreanPath():                # 한글 폰트 경로 설정
  for p in koreanFont:
    if os.path.exists(p):
      return p
  return None

def textCenter(frame, text, font_size=32, color=(255, 255, 255), y=15):          # 텍스트 중앙 표시
  fontPath = koreanPath()
  if not fontPath:
    return frame
  imgPIL = Image.fromarray(frame)
  draw = ImageDraw.Draw(imgPIL)
  try:
    font = ImageFont.truetype(fontPath, font_size)
    bbox = draw.textbbox((0, 0), text, font=font)
    textWidth = bbox[2] - bbox[0]
    x = (screenWidth - textWidth) // 2
    draw.text((x, y), text, font=font, fill=color)
    return np.array(imgPIL)
  except Exception as e:
    print("한글 텍스트 렌더링 실패:", e)
    return frame

def drawText(displayFrame, startTime, count=3):                       # 화면에 텍스트 표시
  passedTime = time.time() - startTime
  remainTime = count - int(passedTime)

  cv2.rectangle(displayFrame, (0, 0), (screenWidth, 60), (0, 0, 0), -1)
  displayFrame = textCenter(displayFrame, "사진 촬영 시작")

  if remainTime > 0:
    timeText = str(remainTime)
    (tw, th), _ = cv2.getTextSize(timeText, cv2.FONT_HERSHEY_SIMPLEX, 4.0, 8)
    cx, cy = screenWidth // 2, screenHeight // 2 + th // 2
    cv2.putText(displayFrame, timeText, (cx - tw // 2, cy),
                cv2.FONT_HERSHEY_SIMPLEX, 4.0, (255, 255, 255), 8, cv2.LINE_AA)

  return max(remainTime, 0), displayFrame

# ================= 업로드 =================
def uploadImage(filepath):                             # 이미지 업로드
  try:
    img = cv2.imread(filepath)
    if img is None:
      print("이미지 로드 실패")
      return None, None
    flippedImage = cv2.flip(img, 1)
    filename = "testuser_selfie.jpg"
    cv2.imwrite(filename, flippedImage)
    try:
      with open(filename, "rb") as f:
        resp = requests.post(uploadURL, files={"file": f})
        print("[업로드] 상태코드:", resp.status_code)
      if resp.status_code == 200:
        try:
          respJson = resp.json()
          print("서버 응답(JSON):", respJson)
        except Exception:
          print("서버 응답(텍스트):", resp.text[:200])
      else:
        print("업로드 실패:", resp.status_code, resp.text[:200])
    except Exception as e:
      print("[업로드] 실패:", e)
    finally:
      if os.path.exists(filename):
        os.remove(filename)
  except Exception as e:
    print("[전송 실패]", e)

# ================= 카메라 시퀀스 =================
def liveCamera(ws, user: str, reqID: str):
  global cameraSource
  filename = f"{user}.jpg"

  with cameraLock:
    if cameraSource is None:
      print("[카메라] 전역 소스가 설정되지 않았습니다.")
      return

    cap = cv2.VideoCapture(cameraSource, cv2.CAP_V4L2)
    if not cap.isOpened():
      print(f"[카메라] 열기 실패: {cameraSource}")
      return

    # 1) 3초 라이브뷰
    cameraStart = time.time()
    while time.time() - cameraStart < 3 and not stopProgram.is_set():
      ret, frame = cap.read()
      if not ret:
        continue
      frame = cv2.flip(frame, 1)
      frame = cv2.resize(frame, (screenWidth, screenHeight))
      showFrame(frame)

    if stopProgram.is_set():
      cap.release()
      return

    # 2) 3초 카운트다운 + 촬영
    countdownStart = time.time()
    while not stopProgram.is_set():
      ret, frame = cap.read()
      if not ret:
        continue
      frame = cv2.flip(frame, 1)
      frame = cv2.resize(frame, (screenWidth, screenHeight))
      remainTime, displayFrame = drawText(frame.copy(), countdownStart, 3)
      showFrame(displayFrame)

      if remainTime == 0:
        cv2.imwrite(filename, frame)
        showFrame(frame)
        time.sleep(3)                    # 촬영 후 사진 3초동안 띄워놓음
        break

    cap.release()
    if stopProgram.is_set():
      return

  # 업로드 수행
  uploadImage(filename)

  # 응답 보내기
  resp = {
    "type": "captured",
    "filename": "testuser_selfie.jpg",
    "req_id": reqID
  }
  try:
    ws.send(json.dumps(resp))
    print("[WS] captured 응답 전송:", resp)
  except Exception as e:
    print("[WS] 응답 전송 실패:", e)

# ================= WebSocket =================
def getID(data: dict):
  rid = data.get("req_id")
  if rid is None and isinstance(data.get("payload"), dict):
    rid = data["payload"].get("req_id")
  return rid

def onMessage(ws, message):
  global currentID, currentUser
  print("[WS 수신]", message)
  try:
    data = json.loads(message)
    payload = data.get("payload", data)
    cmd = payload.get("cmd")
    code = payload.get("code")
    user = "testuser"

    reqID = getID(data)
    print(f"[WS 파싱] cmd={cmd}, code={code}, user={user}, req_id={reqID}")

    # 얼굴 촬영 명령
    if (cmd == "face" or code == 4) and reqID:
      if not liveStream.is_set() and not stopProgram.is_set():
        currentID = reqID
        currentUser = user
        liveStream.set()
        def cameraRun():
          try:
            liveCamera(ws, currentUser, currentID)
          finally:
            liveStream.clear()
            if not stopProgram.is_set():
              showYogi()
        threading.Thread(target=cameraRun, daemon=True).start()

    elif (cmd == "open" or code == 2) and reqID:
      sent = sendArduino(b'2')
      time.sleep(0.1)
      resp = {"type": "opened", "ok": bool(sent), "req_id": reqID}
      ws.send(json.dumps(resp))
      print("[WS] opened 응답 전송:", resp)

    elif (cmd == "lock" or code == 3) and reqID:
      sent = sendArduino(b'3')
      time.sleep(0.1)
      resp = {"type": "locked", "ok": bool(sent), "req_id": reqID}
      ws.send(json.dumps(resp))
      print("[WS] locked 응답 전송:", resp)

  except json.JSONDecodeError:
    print("[WS] JSON 파싱 실패")
  except Exception as e:
    print("[WS] 처리 오류:", e)

def onError(ws, error):
  print("[WS] 오류:", error)

def onClose(ws, code, msg):
  print("[WS] 연결 종료")

def onOpen(ws):
  print("[WS] 연결 성공")
  showYogi()

def startWebsocket():
  ws_app = WebSocketApp(
    wesocketURL,
    on_message=onMessage,
    on_error=onError,
    on_close=onClose,
    on_open=onOpen
  )
  ws_thread = threading.Thread(target=ws_app.run_forever, daemon=True)
  ws_thread.start()
  return ws_app

# ================= 메인 루프 =================
def main_loop():
  initDisplay(fullscreen=True)
  showYogi()
  while not stopProgram.is_set():
    try:
      frame = displayQueue.get(timeout=0.05)
      cv2.imshow(previewName, frame)
    except Empty:
      pass
    key = cv2.waitKey(1) & 0xFF
    if key == 27:
      print("[키입력] ESC -> 종료")
      stopProgram.set()
      break

if __name__ == "__main__":
  initSerial()

  # ▶▶ 카메라 자동 탐색을 "한 번만" 실행해 전역 변수에 고정
  try:
    cameraSource = findCamera()
    print(f"[카메라] 전역 고정 소스: {cameraSource}")
  except Exception as e:
    print("[카메라] 자동 탐색 실패:", e)
    cameraSource = cameraDevice  # 폴백(성공 보장 아님)
    print(f"[카메라] 폴백 사용: {cameraSource}")

  startWebsocket()
  try:
    main_loop()
  except KeyboardInterrupt:
    stopProgram.set()
    print("종료합니다.")
  finally:
    try:
      if ser and ser.is_open:
        ser.close()
    except Exception:
      pass
    try:
      cv2.destroyAllWindows()
    except Exception:
      pass

