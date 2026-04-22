from sqlalchemy import Column, Integer, String
from app.database.session import Base

# 추천 검색어를 저장하는 테이블 (자동완성 기능에 사용)
class RecommendSearch(Base):
  __tablename__ = "recommend_search"

  id = Column(Integer, primary_key=True, index=True)
  searchKeyword = Column(String(50), nullable=False)  # 추천 검색 키워드
