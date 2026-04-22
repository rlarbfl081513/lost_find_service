# app/user/schema.py

from pydantic import BaseModel, Field
from datetime import datetime

class UserCreate(BaseModel):
  username: str = Field(..., example="minwoo123")
  password: str = Field(..., min_length=8, example="abc@1234")
  contact: str = Field(..., example="010-1234-5678")

class UserLogin(BaseModel):
  username: str = Field(..., example="minwoo123")
  password: str = Field(..., example="abc@1234")

class UserResponse(BaseModel):
  id: int
  username: str
  contact: str
  createdAt: datetime

  class Config:
    from_attributes = True
