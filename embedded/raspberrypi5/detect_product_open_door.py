import time
import os
import lgpio
import serial
import requests
from io import BytesIO
from picamera2 import Picamera2
from PIL import Image

# ================= 기본 설정 =================
# 초음파 센서
trig = 24
echo = 23

# 촬영/전송 타이밍
limitCount = 3            # 연속 감지 횟수 기준
distance = 18.5           # cm
cameraDelay = 3           # 트리거 후 촬영까지 시간
arduinoDelay = 5          # 트리거 후 아두이노 전송까지 시간
resetDelay = 5            # 작업 완료 후 다음 트리거까지 대기 시간

# 파일명(항상 동일하게 저장/업로드)
filename = "testuser_product.jpg"
savePath = f"/home/pi/{filename}"

# 업로드 URL
uploadURL = "https://www.yo9i.store/api/v1/upload/upload_product"

# 감지 명령 API URL
apiURL = "http://i13a105.p.ssafy.io:8000/command/detection"

# 크롭 사이즈
cropWidth, cropHeight = 380, 480

def findCamera():                                  # 카메라 인덱스 찾기
  infos = Picamera2.global_camera_info()
  for i, info in enumerate(infos):
    cam_id = (info.get("CameraId") or "").lower()
    if "usb" not in cam_id and "uvc" not in cam_id and ("/base" in cam_id or "platform:" in cam_id):
      return i
  return 0


def measureDist(gpioHandle, echoTimeout=0.03):           # 초음파 거리 측정
  lgpio.gpio_write(gpioHandle, trig, 0)
  time.sleep(0.000002)
  lgpio.gpio_write(gpioHandle, trig, 1)
  time.sleep(0.00001)
  lgpio.gpio_write(gpioHandle, trig, 0)

  t0 = time.perf_counter()
  while lgpio.gpio_read(gpioHandle, echo) == 0:
    if time.perf_counter() - t0 > echoTimeout:
      return 99999.0

  start = time.perf_counter()
  while lgpio.gpio_read(gpioHandle, echo) == 1:
    if time.perf_counter() - start > echoTimeout:
      return 99999.0

  end = time.perf_counter()
  duration = end - start
  distance = (duration * 34300.0) / 2.0
  return distance


def uploadImage(filepath):            # 서버로 사진 전송
  try:
    with open(filepath, "rb") as f:
      files = {'file': (filename, f, 'image/jpeg')}
      resp = requests.post(uploadURL, files=files, timeout=10)
    if resp.ok:
      try:
        data = resp.json()
      except Exception:
        data = resp.text
      print("[업로드] OK:", resp.status_code, str(data)[:200])
      return True, data
    else:
      print("[업로드] 실패:", resp.status_code, resp.text[:200])
      return False, resp.text
  except Exception as e:
    print("[업로드] 예외:", e)
    return False, str(e)


def sendPost(deviceID: str, username: str, conf: float):          # post요청 보내기
  payload = {
    "device_id": deviceID,
    "user_name": username,
    "conf": conf,
  }
  try:
    r = requests.post(apiURL, data=payload, timeout=10)
    print("[detection]", r.status_code, r.text[:200])
    return r.ok
  except Exception as e:
    print("[detection] 전송 예외:", e)
    return False


def saveImage(picam2, savePath):             # 사진 저장
  buf = BytesIO()
  picam2.capture_file(buf, format="jpeg")
  buf.seek(0)

  img = Image.open(buf).convert("RGB")
  imgWidth, imgHeight = img.size

  if imgWidth < cropWidth or imgHeight < cropHeight:
    raise ValueError(f"입력 크기({imgWidth}x{imgHeight})가 크롭 크기({cropWidth}x{cropHeight})보다 작습니다.")

  left   = (imgWidth - cropWidth) // 2
  top    = (imgHeight - cropHeight) // 2
  right  = left + cropWidth
  bottom = top + cropHeight

  cropped = img.crop((left, top, right, bottom))
  cropped.save(savePath, format="JPEG", quality=95)
  return savePath

# GPIO
h = lgpio.gpiochip_open(0)
lgpio.gpio_claim_output(h, trig)
lgpio.gpio_claim_input(h, echo)
lgpio.gpio_write(h, trig, 0)

# 카메라
cameraIndex = findCamera()
picam2 = Picamera2(camera_num=cameraIndex)
picam2.configure(picam2.create_video_configuration(main={"size": (640, 480)}))
picam2.start()
time.sleep(1)

# 아두이노
ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)
time.sleep(2)

# ================= 메인 루프 =================
triggered = False
captureStart = 0.0
photoTaken = False
arduinoSent = False
lastTrigger = 0.0
distCount = 0

try:
  while True:
    dist = measureDist(h)
    print(f"거리: {dist:.1f} cm")

    # 거리 조건 체크
    if dist < distance:
      distCount += 1
    else:
      distCount = 0

    # 트리거 조건: 연속 N회 + 재감지 대기 시간 경과
    if (distCount >= limitCount and not triggered and (time.time() - lastTrigger >= resetDelay)):
      triggered = True
      captureStart = time.time()
      distCount = 0
      print(f"{distance}cm 미만 {limitCount}회 연속 감지")

    # 촬영/업로드/POST 요청
    if triggered and not photoTaken and (time.time() - captureStart >= cameraDelay):
      saveImage(picam2, savePath)
      print(f"사진 저장 완료: {savePath}")
      ok, _ = uploadImage(savePath)
      # 업로드 직후 POST요청
      sendPost(
        deviceID="raspberry01",
        username="testuser",
        conf=0.3,
      )
      photoTaken = True

    # 아두이노로 1 전송
    if triggered and not arduinoSent and (time.time() - captureStart >= arduinoDelay):
      ser.write(b'1')
      print("아두이노로 '1' 전송 완료")
      arduinoSent = True
      lastTrigger = time.time()

    # 상태 초기화
    if triggered and photoTaken and arduinoSent:
      if time.time() - lastTrigger >= resetDelay:
        triggered = False
        photoTaken = False
        arduinoSent = False
        print("상태 초기화 완료. 다음 감지 대기 중")

    time.sleep(0.1)

except KeyboardInterrupt:
    print("사용자에 의해 종료됨")

finally:
  try:
    picam2.stop()
  except Exception:
    pass
  try:
    lgpio.gpiochip_close(h)
  except Exception:
    pass
  try:
    ser.close()
  except Exception:
    pass

