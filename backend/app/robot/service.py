# app/robot/service.py

from sqlalchemy.orm import Session
from app.lost_reports.model import LostReports
from app.robot.model import Items
def createItemByRobot(item, db: Session):
    newItem = Items(
        name="(로봇 등록됨)",
        description="자동 등록",
        location=item.autoLocation,
        category="미분류",
        imageUrl=item.imageUrl,
        robotId=item.robotId,
        userId=None
    )
    db.add(newItem)
    db.commit()
    db.refresh(newItem)
    return newItem

def searchByCategory(db: Session, keyword: str):
  return db.query(Items).filter(Items.category.ilike(f"%{keyword}%")).all()