# app/robot/router.py

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.session import getDb
from app.robot.schema import RobotItemCreate
from app.robot.service import createItemByRobot

router = APIRouter(
    prefix="/api/v1/user/robot",
    tags=["Robot"]
)

@router.post("/register")
def register_item(item: RobotItemCreate, db: Session = Depends(getDb)):
    return createItemByRobot(item, db)
