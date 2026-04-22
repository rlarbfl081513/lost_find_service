from sqlalchemy import Column, Integer, ForeignKey
from app.database.session import Base

# 로봇이 방문 가능한 spot 정보를 저장하는 중계 테이블
class RobotSpots(Base):
  __tablename__ = "robot_spots"

  id = Column(Integer, primary_key=True, index=True)

  robotId = Column(Integer, ForeignKey("robot_numbers.id"))  # 로봇 ID 외래키
  spotId = Column(Integer)  # 스팟 ID (별도 테이블 관리 안 하면 정수로 단순 저장)
