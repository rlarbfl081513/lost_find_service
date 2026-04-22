from sqlalchemy import Column, Integer, String, Boolean, DateTime
from sqlalchemy.orm import relationship
from datetime import datetime
from app.database.session import Base

class Slot(Base):
  __tablename__ = "slots"

  slotId = Column(Integer, primary_key=True, index=True)
  locationDescription = Column(String(100))
  isAvailable = Column(Boolean, default=True)
  lastUsed = Column(DateTime, default=datetime.utcnow)

  # 관계
  item = relationship("Items", back_populates="slot")
