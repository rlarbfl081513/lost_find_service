from sqlalchemy import Column, Integer
from app.database.session import Base

# 로봇 번호를 저장하는 테이블 
class RobotNumber(Base):
  __tablename__ = "robot_numbers"

  id = Column(Integer, primary_key=True, index=True)
