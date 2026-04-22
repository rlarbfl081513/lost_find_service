# app/item/schema.py

from pydantic import BaseModel
from datetime import datetime
from typing import Optional


# 내 분실물 수정
# 'UserItemUpdate'는 사용자가 자신의 분실물을 수정할 때 사용하는 스키마`
class UserItemUpdate(BaseModel):
  description: Optional[str] = None
  category: str
  color: str
  imageUrl: Optional[str] = None

# 내 분실물 등록
# 'UserItemCreate'는 사용자가 분실물을 등록할 때 사용하는 스키마`
class UserItemCreate(BaseModel):
  description: Optional[str] = None
  category: str
  color: str
  imageUrl: Optional[str] = None
  
  class Config:
        orm_mode = True
        
# 내 분실물 조회 응답
# 'UserItemResponse'는 사용자가 자신의 분실물을 조회할 때 사용하는 스키
class UserItemResponse(BaseModel):
  id: int
  description: Optional[str] = None
  category: str
  color: str
  imageUrl: Optional[str] = None
  # status: str
  # userId: Optional[int] = None

  class Config:
      from_attributes = True
  

# 분실물 수정 응답
class UpdateItemResponse(BaseModel):
    id: int
    description: Optional[str] = None
    category: str
    color: str
    imageUrl: Optional[str] = None

    class Config:
      from_attributes = True

# 분실물 삭제 응답
class DeleteItemResponse(BaseModel):
    id: int

    class Config:
      from_attributes = True


# 메시지와 함께 분실물 등록 응답      
class CreateItemResponse(BaseModel):
    message: str
    item: UserItemResponse  # 기존 정의된 스키마 재사용

    class Config:
        from_attributes = True
        

        
# 분실물 수령 요청 응답
class ClaimRequestResponse(BaseModel):
    id: int
    status: str

    model_config = {
        "from_attributes": True
    }
    
# 분실물 수령 취소 응답
class CancelClaimResponse(BaseModel):
    id: int
    status: str

    model_config = { "from_attributes": True }

# 분실물 수령 완료 응답
class CompleteClaimResponse(BaseModel):
    id: int
    status: str

    model_config = { "from_attributes": True }