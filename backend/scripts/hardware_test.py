# import requests

# # FastAPI 서버 주소 (IP와 포트에 맞게 수정)
# url = "http://192.168.137.17:8765/send-signal/2"

# try:
#     response = requests.post(url)
#     print("🔼 신호 전송 완료!")
#     print("📨 서버 응답:", response.json())
# except Exception as e:
#     print("⚠️ 에러 발생:", e)

from fastapi import APIRouter
import requests

router = APIRouter(
    prefix="/api/v1/hardware",
    tags=["Robot"]
)

@router.post("/send-signal/{num}")
def send_signal(num: int):
    # 하드웨어 쪽으로 신호 POST
    resp = requests.post(f"http://192.168.137.17:8765/send-signal/{num}")
    return {"status": resp.status_code, "hardware_response": resp.text}
