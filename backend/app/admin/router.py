from fastapi import APIRouter, Depends, status
from sqlalchemy.orm import Session
from typing import List
from fastapi import Depends, HTTPException, status
from app.database.session import getDb
from app.user.model import User
from app.user.schema import UserResponse
from app.admin.dependencies import getCurrentAdminUser
from app.admin.service import deleteUserById, getAllRobotItems, deleteItemById, updateItemStatus, getExpiredRobotItems
from app.admin.schema import RobotItemResponse, ItemStatusUpdate, RobotItemResponse


router = APIRouter(prefix="/api/v1/admin", tags=["Admin"])

@router.get("", response_model=List[UserResponse])
def readAllUsers(
    db: Session = Depends(getDb),
  currentAdmin = Depends(getCurrentAdminUser) 
):
  return db.query(User).all()

@router.delete("/users/{user_id}", status_code=status.HTTP_200_OK)
def deleteUser(user_id: int, db: Session = Depends(getDb), currentAdmin = Depends(getCurrentAdminUser)):
  return deleteUserById(userId=user_id, db=db)


@router.get("/items", response_model=list[RobotItemResponse], summary="ReadAllRobotItems")
def readAllRobotItems(db: Session = Depends(getDb), currentAdmin = Depends(getCurrentAdminUser)):
  return getAllRobotItems(db)

@router.delete("/items/{item_id}")
def deleteItem(item_id: int, db: Session = Depends(getDb), currentAdmin = Depends(getCurrentAdminUser)):
  return deleteItemById(itemId=item_id, db=db)


@router.patch("/items/{item_id}/status", summary="UpdateItemStatus")
def updateStatus(
  item_id: int,
  updateReq: ItemStatusUpdate,
  db: Session = Depends(getDb),
  currentAdmin = Depends(getCurrentAdminUser)
):
  return updateItemStatus(itemId=item_id, newStatus=updateReq.status, db=db)

@router.get(
  "/items/expired",
  response_model=list[RobotItemResponse],
  summary="GetExpiredRobotItems"
)
def readExpiredRobotItems(
  db: Session = Depends(getDb),
  currentAdmin = Depends(getCurrentAdminUser)
):
  return getExpiredRobotItems(db)
