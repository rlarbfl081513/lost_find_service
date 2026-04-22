# app/auth/utils.py
from dotenv import load_dotenv
load_dotenv()
from datetime import datetime, timedelta
from jose import jwt, JWTError
from fastapi import HTTPException, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.orm import Session
from app.database.session import getDb
import hashlib
import os

SECRET_KEY = os.getenv("JWT_SECRET_KEY")
ALGORITHM = os.getenv("JWT_ALGORITHM", "HS256")

# ▶ 옵션: 운영에선 별도 키 권장
REFRESH_SECRET = os.getenv("JWT_REFRESH_SECRET_KEY")
ACCESS_EXPIRE_MIN = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES"))
REFRESH_EXPIRE_DAYS = int(os.getenv("REFRESH_TOKEN_EXPIRE_DAYS"))

oauth2_scheme = HTTPBearer()

def createAccessToken(data: dict, expires_minutes: int = ACCESS_EXPIRE_MIN):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=expires_minutes)
    to_encode.update({"exp": expire, "iat": datetime.utcnow(), "token_type": "access"})
    
    if "sub" in to_encode and not isinstance(to_encode["sub"], str):
        to_encode["sub"] = str(to_encode["sub"])
        to_encode.update({"exp": expire, "iat": datetime.utcnow(), "token_type": "access"})
   
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

# ▶ 추가: refresh 발급
def createRefreshToken(user_id: int):
    print("ISSUE_REFRESH RSUM:", hashlib.sha256(REFRESH_SECRET.encode()).hexdigest()[:8], "ALG:", ALGORITHM)

    to_encode = {"sub": str(user_id), "iat": datetime.utcnow(), "token_type": "refresh"}
    expire = datetime.utcnow() + timedelta(days=REFRESH_EXPIRE_DAYS)
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, REFRESH_SECRET, algorithm=ALGORITHM)

# ▶ 추가: refresh 검증
def verifyRefreshToken(token: str) -> int:
    print("RAW TOKEN [", token, "]")
    print("RAW TOKEN:", repr(token))
    print("VERIFY_REFRESH RSUM:", hashlib.sha256(REFRESH_SECRET.encode()).hexdigest()[:8], "ALG:", ALGORITHM)

    try:
        payload = jwt.decode(token, REFRESH_SECRET, algorithms=[ALGORITHM])
        if payload.get("token_type") != "refresh":
            raise HTTPException(status_code=401, detail="Invalid refresh token type")
        sub = payload.get("sub")
        if sub is None:
            raise HTTPException(status_code=401, detail="Invalid refresh token")
        return int(sub)
    except JWTError as e:
        # ▶ 여기서 실제 오류 메시지를 찍어서 원인을 파악합니다
        print("JWTError during refresh verify:", str(e))
        raise HTTPException(status_code=401, detail="Invalid refresh token")

# (기존) 보호용: access만 허용
def getCurrentUser(token: HTTPAuthorizationCredentials = Depends(oauth2_scheme), db: Session = Depends(getDb)):
    payload = jwt.decode(token.credentials, SECRET_KEY, algorithms=[ALGORITHM])
    if payload.get("token_type") != "access":
        raise HTTPException(status_code=401, detail="Invalid token")
    sub = payload.get("sub")
    if sub is None:
        raise HTTPException(status_code=401, detail="Invalid token")
    try:
        return int(sub)
    except (ValueError, TypeError):
        raise HTTPException(status_code=401, detail="Invalid token")