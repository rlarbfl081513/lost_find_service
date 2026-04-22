# app/user/schema.py

from pydantic import BaseModel, Field
from datetime import datetime

class UserCreate(BaseModel):
  username: str = Field(..., min_length=1)
  password: str = Field(..., min_length=8)
  contact: str = Field(...)

class UserLogin(BaseModel):
  username: str
  password: str

class UserResponse(BaseModel):
  id: int
  username: str
  contact: str
  createdAt: datetime

  class Config:
    from_attributes = True
