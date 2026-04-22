# app/user/router.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.user.schema import UserCreate, UserResponse
from app.user.service import createUser, deleteUser
from app.database.session import getDb
from app.auth.utils import getCurrentUser

router = APIRouter(
  prefix="/api/v1/user",
  tags=["User"]
)

@router.post("/signup", response_model=UserResponse)
def registerUser(userCreate: UserCreate, db: Session = Depends(getDb)):
  user = createUser(userCreate, db)
  if not user:
    raise HTTPException(status_code=400, detail="이미 존재하는 사용자입니다.")
  return user

@router.delete("/delete")
def deleteMyAccount(
  db: Session = Depends(getDb),
  currentUserId: int = Depends(getCurrentUser)
):
  success = deleteUser(currentUserId, db)
  if success:
    return {"message": "회원 탈퇴가 완료되었습니다."}
  raise HTTPException(status_code=404, detail="사용자를 찾을 수 없습니다.")
