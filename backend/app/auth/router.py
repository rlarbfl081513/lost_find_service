from fastapi import APIRouter, Request, Depends, HTTPException
from sqlalchemy.orm import Session
from app.auth.oauth import oauth
from app.auth.provider_handler import getUserInfo  # (id, name/nickname, email 반환)
from app.auth.utils import createAccessToken,createRefreshToken,verifyRefreshToken
from app.database.session import getDb
from app.user.model import User
from pydantic import BaseModel
import os

router = APIRouter(prefix="/api/v1/auth", tags=["Auth"])

def getClient(provider: str):
    client = getattr(oauth, provider, None)  # ✅ 등록된 인스턴스 직접 사용
    if client is None:
        raise HTTPException(400, "지원하지 않는 소셜 로그인입니다.")
    return client

@router.get("/{provider}/login")
async def login(provider: str, request: Request):
    client = getClient(provider)
    redirect_uri = os.getenv(f"{provider.upper()}_REDIRECT_URI") \
                   or str(request.url_for("callback", provider=provider))
    return await client.authorize_redirect(
    request,
    redirect_uri,
    scope="account_email profile_nickname",   
)

@router.get("/{provider}/callback", name="callback")
async def callback(provider: str, request: Request, db: Session = Depends(getDb)):
    client = getClient(provider)

    # ✅ 여기서 설정이 유실되지 않도록 등록된 client 인스턴스를 그대로 사용
    token = await client.authorize_access_token(request)

    if provider == "kakao":
        resp = await client.get("/v2/user/me", token=token)
        raw = resp.json()
        user_data = getUserInfo("kakao", raw)  # ✅ raw를 넘김
    else:
        raise HTTPException(400, "지원하지 않는 소셜 로그인입니다.")

    if not user_data.get("id"):
        raise HTTPException(400, "사용자 정보 조회 실패")

    # (provider, provider_user_id)로 upsert 하려면 서비스 레이어 사용 권장
    user = db.query(User).filter(
        User.provider == provider,
        User.provider_user_id == user_data["id"]
    ).first()

    if not user:
        user = User(
            provider=provider,
            provider_user_id=user_data["id"],
            username=user_data.get("username") or f"{provider}_{user_data['id']}",
            contact=user_data.get("email") or f"{user_data['id']}@{provider}.user",
            password=None,
        )
        db.add(user); db.commit(); db.refresh(user)

    access = createAccessToken({"sub": user.id})
    refresh = createRefreshToken(user.id)
    
    user.refresh_token = refresh
    db.add(user); db.commit(); db.refresh(user)

    return {
        "access_token": access,
        "refresh_token": refresh,
        "token_type": "bearer",
        "user": {"id": user.id, "username": user.username, "contact": user.contact},
    }



class RefreshRequest(BaseModel):
    refresh_token: str

@router.post("/refresh")
def refresh(req: RefreshRequest, db: Session = Depends(getDb)):
    # refresh() 내부, try/except로 감싸 진단
    try:
        user_id = verifyRefreshToken(req.refresh_token)  # 여기서 터지면 '디코드 실패'
    except HTTPException as e:
        print("VERIFY_FAIL:", e.detail)  # Invalid refresh token / type 등
        raise
    
    user = db.query(User).filter(User.id == user_id).first()
    if not user or user.refresh_token != req.refresh_token:
        print("MISMATCH:", "no_user" if not user else "token_diff")
        raise HTTPException(status_code=401, detail="Refresh not recognized")
   
    # 새 access 발급
    new_access = createAccessToken({"sub": user_id})

    # ▶ 회전(선택): 새 refresh도 발급하여 교체
    new_refresh = createRefreshToken(user_id)
    user.refresh_token = new_refresh
    db.add(user); db.commit()

    return {
        "access_token": new_access,
        "refresh_token": new_refresh,  # 회전하지 않으려면 기존 값 유지 후 이 필드 제거
        "token_type": "bearer",
    }