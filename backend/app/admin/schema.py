# app/user/schema.py

from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class UserResponse(BaseModel):
  id: int
  username: str
  contact: str
  is_admin: bool

  class Config:
    from_attributes = True

# 로봇등록 조회 스키마
class RobotItemResponse(BaseModel):
  id: int
  category: str
  subcategoryBig: Optional[str] = None
  subcategorySmall: Optional[str] = None
  color: Optional[str] = None
  imageUrl: Optional[str] = None
  slotId: Optional[int] = None
  status: Optional[str] = None
  foundLocation: Optional[str] = None
  registeredDate: Optional[datetime] = None

  class Config:
    from_attributes = True

# 상태 수정 요청 스키마
class ItemStatusUpdate(BaseModel):
  status: str

# item 응답 스키마
class ExpiredItemResponse(BaseModel):
  id: int
  title: str
  category: str
  status: str
  createdAt: datetime
  robotId: Optional[str] = None
  userId: Optional[int] = None
  claimerId: Optional[int] = None

  class Config:
    from_attributes = True