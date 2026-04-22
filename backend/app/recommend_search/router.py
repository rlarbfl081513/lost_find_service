from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.session import getDb
from app.recommend_search.service import getAllRecommendKeywords
from app.recommend_search.schema import RecommendSearchResponse

router = APIRouter(prefix="/api/v1", tags=["RecommendSearch"])

# 전체 추천 검색어 조회 API
@router.get("/recommend-search", response_model=list[RecommendSearchResponse])
def readAllRecommendSearches(db: Session = Depends(getDb)):
  return getAllRecommendKeywords(db)
