from sqlalchemy import Column, Integer, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from datetime import datetime
from app.database.session import Base

# 수령 시 확인 정보
class RetrievalLog(Base):
  __tablename__ = "retrieval_logs"

  logId = Column(Integer, primary_key=True, index=True)
  userId = Column(Integer, ForeignKey("users.id"))
  idcardId = Column(Integer, ForeignKey("id_cards.idcardId"))
  itemId = Column(Integer, ForeignKey("items.id"))  # 수령 대상: 로봇이 등록한 실제 아이템

  retrievedTime = Column(DateTime, default=datetime.utcnow)

  # 관계
  user = relationship("User", back_populates="retrievalLogs")
  idCard = relationship("IDCard", back_populates="retrievalLogs")
  item = relationship("Items", back_populates="retrievalLogs")
