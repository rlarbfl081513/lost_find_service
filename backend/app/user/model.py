# app/user/models.py

from sqlalchemy import Column, Integer, String, DateTime, Boolean
from sqlalchemy.orm import relationship
from datetime import datetime
from app.database.session import Base

class User(Base):
  __tablename__ = "users"

  id = Column(Integer, primary_key=True, index=True)
  username = Column(String, unique=True, nullable=False, index=True)
  password = Column(String, nullable=True)
  contact = Column(String, nullable=False)
  isAdmin = Column(Boolean, default=False)
  createdAt = Column(DateTime, default=datetime.utcnow)

  # 소셜 매핑용
  provider = Column(String(20), nullable=True)             # 'kakao','google','local' 등
  providerUserId = Column(String, nullable=True, index=True)
  refreshToken = Column(String, nullable=True)

  lostReports = relationship("LostReports", back_populates="user")
  idCards = relationship("IDCard", back_populates="user")
  retrievalLogs = relationship("RetrievalLog", back_populates="user")