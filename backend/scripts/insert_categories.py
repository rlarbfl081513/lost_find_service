# scripts/insert_categories.py

import sys, os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from sqlalchemy.orm import Session
from app.database.session import SessionLocal
from app.category.model import Category

db: Session = SessionLocal()

# 1차 카테고리 추가
firstDepth = ["스마트폰", "지갑", "이어폰", "시계", "악세사리", "기타"]
firstDepthIds = {}

for title in firstDepth:
  category = Category(title=title, depth=0)
  db.add(category)
  db.flush()  # ID 확보용 (commit 전)
  firstDepthIds[title] = category.id

# 2차 카테고리 (스마트폰 하위)
phone_samsung = Category(title="삼성", depth=1, parentId=firstDepthIds["스마트폰"])
phone_apple = Category(title="애플", depth=1, parentId=firstDepthIds["스마트폰"])
db.add_all([phone_samsung, phone_apple])
db.flush()

# 2차 카테고리 (이어폰 하위)
ear_samsung = Category(title="삼성", depth=1, parentId=firstDepthIds["이어폰"])
ear_apple = Category(title="애플", depth=1, parentId=firstDepthIds["이어폰"])
db.add_all([ear_samsung, ear_apple])
db.flush()



# 스마트폰 3차 카테고리 - 삼성 하위
samsungSub = ["S23 이상", "S22 이하", "Z폴드", "Z플립", "기타"]
for title in samsungSub:
  db.add(Category(title=title, depth=2, parentId=phone_samsung.id))

# 스마트폰 3차 카테고리 - 애플 하위
appleSub = ["12 이하", "13~15", "16", "pro"]
for title in appleSub:
  db.add(Category(title=title, depth=2, parentId=phone_apple.id))


# 스마트폰 3차 카테고리 - 삼성 하위
samsungSub = ["버즈프로1", "버즈프로2", "버즈프로3"]
for title in samsungSub:
  db.add(Category(title=title, depth=2, parentId=ear_samsung.id))

# 스마트폰 카테고리 - 애플 하위
appleSub = ["에어팟프로", "에어팟3",]
for title in appleSub:
  db.add(Category(title=title, depth=2, parentId=ear_apple.id))



# 최종 반영
db.commit()
print("✅ 카테고리 계층 삽입 완료")
