import sys, os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from sqlalchemy.orm import Session
from app.database.session import SessionLocal
from app.recommend_search.model import RecommendSearch

# 추천 검색어 리스트
keywords = ["지갑", "무선이어폰", "핸드폰", "악세사리"]

# DB 세션
db: Session = SessionLocal()

# 중복 없이 삽입
for word in keywords:
  exists = db.query(RecommendSearch).filter_by(searchKeyword=word).first()
  if not exists:
    db.add(RecommendSearch(searchKeyword=word))

db.commit()
print("✅ 추천 검색어 데이터 삽입 완료")
