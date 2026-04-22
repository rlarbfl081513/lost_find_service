# app/robot/schema.py

from pydantic import BaseModel
from typing import Optional,List
from datetime import date

class RobotItemCreate(BaseModel):
    imageUrl: str
    robotId: str
    autoLocation: str

class RobotItemResponse(BaseModel):
    title: str
    categoryId: int
    color: Optional[str]
    imageUrl: str
    slotId: int
    status: str
    foundLocation: str
    registeredDate: date

    class Config:
      from_attributes = True


# 최근 분실물 조회
class LatestRobotItemResponse(BaseModel):
    id: int
    title: str
    imageUrl: str
    foundLocation: str
    registeredDate: date

    class Config:
      from_attributes = True
      
# 카테고리 세부 정보 조회
class CategoryResponse(BaseModel):
   id: int
   title : str
#    parent: Optional["CategoryResponse"]=[]
   children: List["CategoryResponse"]=[] # 하위카테고리 불러오기
   
   class Config:
       from_attributes = True


# 분실물 상세 조회
class DetialRobotItemResponse(BaseModel):
    id: int
    title: str
    imageUrl: str
    category: CategoryResponse
    foundLocation: str
    registeredDate: date

    class Config:
       orm_mode = True  
       from_attributes = True
       

# 바로가기 카테고리 버튼
# class ShortcutCategory(BaseModel):
#     depth: int   
#     id: int
#     title: str
   