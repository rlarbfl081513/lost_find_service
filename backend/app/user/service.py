# app/user/service.py

from sqlalchemy.orm import Session
from app.user.model import User
from app.user.schema import UserCreate
# from app.auth.utils import hashPassword


def upsert_social_user(
    db: Session,
    provider: str,
    provider_user_id: str,
    username: str | None,
    email: str | None,
) -> User:
    # 1) provider + provider_user_id로 조회
    user = (db.query(User)
              .filter(User.provider == provider,
                      User.provider_user_id == provider_user_id)
              .first())
    # 2) 없으면 생성
    if not user:
        user = User(
            provider=provider,
            provider_user_id=provider_user_id,
            username=username or f"{provider}_{provider_user_id}",
            # 현재 모델은 email 컬럼 대신 contact 필드를 사용하고 있으므로 여기에 저장
            contact=email or f"{provider_user_id}@{provider}.user",
            # 소셜 계정은 비밀번호가 없으므로 NULL 허용(모델에서 nullable=True)
            password=None,
        )
        db.add(user)
        db.commit()
        db.refresh(user)
    return user

def createUser(userCreate: UserCreate, db: Session):
  # 중복 확인
  if db.query(User).filter(User.username == userCreate.username).first():
    return None

  newUser = User(
    username=userCreate.username,
    # password=hashPassword(userCreate.password),
    contact=userCreate.contact
  )
  db.add(newUser)
  db.commit()
  db.refresh(newUser)
  return newUser

def deleteUser(userId: int, db: Session):
  user = db.query(User).filter(User.id == userId).first()
  if user:
    db.delete(user)
    db.commit()
    return True
  return False

def getAllUsers(db: Session):
  return db.query(User).all()