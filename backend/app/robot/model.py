# app/robot/model.py
from sqlalchemy import Column, Integer, String, Text, Date, ForeignKey, JSON
from sqlalchemy.orm import relationship
from datetime import datetime
from app.database.session import Base
from app.matched_items.connection import lost_report_item_connection
from app.color.model import Color
from app.robot_number.model import RobotNumber
from app.category.model import Category 

class Items(Base):
  __tablename__ = "items"

  id = Column(Integer, primary_key=True, index=True)
  title = Column(String)
  # category = Column(String(50), nullable=True)
  color = Column(String(20))
  imageUrl = Column(Text, nullable=False)
  slotId = Column(Integer, ForeignKey("slots.slotId"))
  status = Column(String(20),default="등록")
  foundLocation = Column(String(50))
  registeredDate = Column(Date, default=datetime.utcnow().date)
  robotNumber = Column(Integer)
  extraInfo = Column(String)
  colorId = Column(Integer, ForeignKey("colors.id"))  # 색상 외래키
  robotNumberId = Column(Integer, ForeignKey("robot_numbers.id"))  # 외래키
  categoryId = Column(Integer, ForeignKey("categories.id"))

  # 관계
  matchedReports = relationship("LostReports", secondary=lost_report_item_connection, back_populates="matchedItems")
  retrievalLogs = relationship("RetrievalLog", back_populates="item")
  slot = relationship("Slot", back_populates="item")
  color = relationship("Color")
  category = relationship("Category",backref="items")

# 하드웨어에서 받아올 것
class RobotLocation(Base):
  __tablename__="robot_locations"
  
  id = Column(Integer, primary_key=True, index=True)
  robotId = Column(String, nullable=False)
  currentLocation = Column(String, nullable=False) # 예) A-스팟
  arrivalEstimates  = Column(JSON, nullable=False) # 예) {"A":"12:00", "B":"12:05", "C":"12:10"}
  