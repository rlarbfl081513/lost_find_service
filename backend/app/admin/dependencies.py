from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.orm import Session
from app.auth.utils import getCurrentUser
from app.database.session import getDb  # ✅ 정확한 경로로 수정
from app.user.model import User

# ✅ 토큰 인증 방식 정의
oauth2Scheme = HTTPBearer()

# ✅ 현재 관리자 사용자 확인
def getCurrentAdminUser(
  token: HTTPAuthorizationCredentials = Depends(oauth2Scheme),
  db: Session = Depends(getDb)
):
  userId = getCurrentUser(token)
  user = db.query(User).filter(User.id == userId).first()

  if not user or not user.is_admin:
    raise HTTPException(
      status_code=status.HTTP_403_FORBIDDEN,
      detail="관리자 권한이 필요합니다."
    )
  return user
