# scripts/create_admin.py

from app.database.session import SessionLocal
from app.user.model import User
from app.auth.utils import hashPassword  # ✅ 비밀번호 해시 함수 import

def createAdmin():
  db = SessionLocal()

  existing = db.query(User).filter(User.username == "A105").first()
  if existing:
    print("⚠️ 이미 A105 계정이 존재합니다.")
    return

  admin = User(
    username="A105",
    password=hashPassword("A105@@@@"),  # ✅ 해시된 비밀번호로 저장
    contact="010-0000-0000",
    is_admin=True
  )

  db.add(admin)
  db.commit()
  print("✅ 관리자 계정 생성 완료")

if __name__ == "__main__":
  createAdmin()
