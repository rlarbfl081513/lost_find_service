import os
from fastapi import APIRouter
import requests

router = APIRouter(
    prefix="/api/v1/hardware",
    tags=["Robot"]
)

HARDWARE_URL = os.getenv("HARDWARE_URL", "")

@router.post("/send-signal/{num}")
def send_signal(num: int):
    resp = requests.post(f"{HARDWARE_URL}/send-signal/{num}")
    return {"status": resp.status_code, "hardware_response": resp.text}
