from sqlalchemy import Column, Integer, String, Text, DateTime, ForeignKey, JSON
from sqlalchemy.orm import relationship
from datetime import datetime
from app.database.session import Base

class IDCard(Base):
  __tablename__ = "id_cards"

  idcardId = Column(Integer, primary_key=True, index=True)
  userId = Column(Integer, ForeignKey("users.id"))
  s3_Url = Column(Text, nullable=False)
  idcardType = Column(String(20))
  registeredAt = Column(DateTime, default=datetime.utcnow)
  ownerName = Column(String(50))
  extraInfo = Column(JSON)

  # 관계
  user = relationship("User", back_populates="idCards")
  retrievalLogs = relationship("RetrievalLog", back_populates="idCard")
