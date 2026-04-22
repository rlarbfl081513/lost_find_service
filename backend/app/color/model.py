#app/color/model.py
from sqlalchemy import Column, Integer, String
from app.database.session import Base

# 물건의 색상을 저장하는 테이블 (이름 + HEX값)
class Color(Base):
  __tablename__ = "colors"

  id = Column(Integer, primary_key=True, index=True)
  colorName = Column(String(20), nullable=False)  # 예: "빨강"
  hexValue = Column(String(10), nullable=False)   # 예: "#FF0000"
