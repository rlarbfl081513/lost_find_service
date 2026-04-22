import requests
    
# app/auth/provider_handler.py
def getUserInfo(provider: str, raw: dict):
    if provider == "kakao":
        kakao_id = str(raw["id"])
        acc = raw.get("kakao_account", {}) or {}
        # name 동의 받지 못하면 profile.nickname으로 폴백
        profile = acc.get("profile") or {}
        name = acc.get("name") or profile.get("nickname")
        email = acc.get("email")
        return {
            "id": kakao_id,
            "username": name or f"kakao_{kakao_id}",
            "email": email,
        }
    raise ValueError(f"Unsupported provider: {provider}")
