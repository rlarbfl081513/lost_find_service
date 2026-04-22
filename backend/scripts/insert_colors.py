from sqlalchemy.orm import Session
from app.database.session import SessionLocal
from app.color.model import Color

# 기본 색상 데이터
colors = [
  ("빨강", "#FE9696"),
  ("주황", "#FFBC40"),
  ("노랑", "#FEE696"),
  ("초록", "#96FEDF"),
  ("파랑", "#96ABFE"),
  ("남색", "#3D395A"),
  ("보라색","#BE2DCB"),
  ("갈색", "#CB772D"),
  ("흰색", "#FFFFFF"),
  ("검정색", "#000000"),
  ("분홍색", "#FB7D7D"),
]

# DB 연결
db: Session = SessionLocal()

# 색상 데이터 삽입
for name, hexCode in colors:
  color = Color(colorName=name, hexValue=hexCode)
  db.add(color)

db.commit()
print("✅ 색상 데이터 삽입 완료!")
