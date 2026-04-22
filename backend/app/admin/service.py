from sqlalchemy.orm import Session
from app.user.model import User
from fastapi import HTTPException
from app.robot.model import Items 
from app.lost_reports.model import LostReports
from datetime import datetime, timedelta

# 전체 사용자 조회 함수
def getAllUsers(db: Session):
  return db.query(User).all()


# 삭제 서비스 함수
def deleteUserById(userId: int, db: Session):
  user = db.query(User).filter(User.id == userId).first()
  if not user:
    raise HTTPException(status_code=404, detail="존재하지 않는 사용자입니다.")
  
  db.delete(user)
  db.commit()
  return {"message": "삭제되었습니다."}


# 로봇 등록 분실물 조회 함수 추가
def getAllRobotItems(db: Session):
  items = db.query(Items).all()
  return items

# 게시글 삭제 함수 추가

def deleteItemById(itemId: int, db: Session):
  item = db.query(LostReports).filter(LostReports.id == itemId).first()
  if not item:
    raise HTTPException(status_code=404, detail="존재하지 않는 분실물 게시글입니다.")
  
  db.delete(item)
  db.commit()
  return {"message": "분실물 게시글이 삭제되었습니다."}


def updateItemStatus(itemId: int, newStatus: str, db: Session):
  item = db.query(LostReports).filter(LostReports.id == itemId).first()
  if not item:
    raise HTTPException(status_code=404, detail="해당 분실물 게시글이 존재하지 않습니다.")
  
  item.status = newStatus
  db.commit()
  db.refresh(item)
  return {"message": f"분실물 상태가 '{newStatus}'(으)로 변경되었습니다."}

# 7일 이상 보관된 분실물 조회 함수
def getExpiredRobotItems(db: Session):
  threshold = datetime.utcnow() - timedelta(days=7)
  items = db.query(Items).filter(Items.registeredDate <= threshold).all()
  return items