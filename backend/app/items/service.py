# app/item/service.py

from sqlalchemy.orm import Session
from fastapi import HTTPException
from app.robot.model import Items
from datetime import datetime,timedelta
from sqlalchemy.exc import SQLAlchemyError
from app.robot.schema import CategoryResponse

# 최근 분실물 리스트 (최근 3일 이내)
  #  현재(UTC) 날짜를 구해 최신순으로 나오도록
def getLatestRobotItems(db: Session, limit: int = 5):
    return (
        db.query(Items)
          .order_by(Items.registeredDate.desc())
          .limit(limit)
          .all()
    )


# 전체 리스트
def getAllRobotItems(db: Session):
    return db.query(Items).all()

# 필터를 통한 분실물 조회 
def filterRobotItems(
    db: Session, 
    category: int = None, 
    color: str = None,
    start_date: datetime = None,
    end_date: datetime = None
):
  
  query = db.query(Items)

  if category:
    query = query.filter(Items.categoryId == category)
  if color:
    query = query.filter(Items.color == color)
  if start_date:
    query = query.filter(Items.registeredDate >= start_date)
  if end_date:
    query = query.filter(Items.registeredDate <= end_date)

  return query.all()



# 상세조회 시 부모>자식1>자식2 형태로 받기위한 함수_1
def getCategoryPath_list(category):
    path = []
    while category:
        path.append(category)
        category = category.parent
    return list(reversed(path))  # root → leaf

# 상세조회 시 부모>자식1>자식2 형태로 받기위한 함수_2
def buildCategoryTreeFromPath(path_list):
    """경로 리스트 [root,...,leaf]를 children 구조 트리로 변환"""
    if not path_list:
        return None
    root = CategoryResponse(
        id=path_list[0].id,
        title=path_list[0].title,
        children=[]
    )
    current = root
    for cat in path_list[1:]:
        child = CategoryResponse(id=cat.id, title=cat.title, children=[])
        current.children.append(child)
        current = child
    return root