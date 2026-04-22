from sqlalchemy.orm import Session
from app.recommend_search.model import RecommendSearch

# 전체 추천 검색어 조회
def getAllRecommendKeywords(db: Session):
  return db.query(RecommendSearch).all()
