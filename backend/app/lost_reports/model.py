# app/item/model.py

from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Text
from sqlalchemy.orm import relationship
from datetime import datetime
from app.database.session import Base
from app.matched_items.connection  import lost_report_item_connection
from app.category.model import Category

# 'User' 관계 선언 방지용 처리
try:
  from app.user.model import User
except:
  User = None

class LostReports(Base):
  __tablename__ = "lost_reports"

  id = Column(Integer, primary_key=True, index=True)
  description = Column(String(100), nullable=True) # 선택 입력 값
  category = Column(String(50), nullable=False) # 필수 입력 값
  color = Column(String(20), nullable=True)
  lostItemImg = Column(Text, nullable=True)
  
  status = Column(String(20), default="등록") 
  createdAt = Column(DateTime, default=datetime.utcnow)
  
  # 일대다 관계
  userId = Column(Integer, ForeignKey("users.id"))
  user = relationship("User", back_populates="lostReports")
  
  # 다대다 관계
  matchedItemId = Column(Integer, ForeignKey("items.id"), nullable=True)
  matchedItems = relationship("Items", secondary=lost_report_item_connection, back_populates="matchedReports")

  categoryId = Column(Integer, ForeignKey("categories.id"))  # 외래키 연결
  categoryRel = relationship("Category")  # 관계 설정