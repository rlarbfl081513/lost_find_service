# scripts/create_admin.py

import os
from app.database.session import SessionLocal
from app.user.model import User
from app.auth.utils import hashPassword

def createAdmin():
  db = SessionLocal()

  adminUsername = os.getenv("ADMIN_USERNAME", "admin")
  adminPassword = os.getenv("ADMIN_PASSWORD", "")
  adminContact = os.getenv("ADMIN_CONTACT", "")

  existing = db.query(User).filter(User.username == adminUsername).first()
  if existing:
    print("⚠️ 이미 관리자 계정이 존재합니다.")
    return

  admin = User(
    username=adminUsername,
    password=hashPassword(adminPassword),
    contact=adminContact,
    is_admin=True
  )

  db.add(admin)
  db.commit()
  print("✅ 관리자 계정 생성 완료")

if __name__ == "__main__":
  createAdmin()
