# router.py
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from typing import Optional, List
from app.all_response import ResponseEnvelope
from app.database.session import getDb
from app.search.schema import ItemWithDetail
from app.search.service import (
  filterItemsByKeyword,
  getAllCategories,
  getAllColors,
  buildCategoryChain
)
from app.color.model import Color

router = APIRouter(prefix="/api/v1/search", tags=["Search"])

@router.get(
    "/full",
    response_model=ResponseEnvelope[List[ItemWithDetail]],
    summary="전체 검색 (아이템+카테고리+색상)"
)
def searchFull(
    query: Optional[str] = Query(None),
    categoryId: Optional[int] = Query(None),
    colorIds: Optional[List[int]] = Query(None),  
    db: Session = Depends(getDb)
):
    items = filterItemsByKeyword(db, query, categoryId, colorIds)
    fullCategories = getAllCategories(db)
    allColors = getAllColors(db)

    result_items = []
    for item in items:
        chain = buildCategoryChain(fullCategories, item.categoryId)
        color_data = next((c for c in allColors if c["id"] == item.colorId), None)
        result_items.append({
            "id": item.id,
            "title": item.title,
            "foundLotation": item.foundLocation,
            "registeredDate": item.registeredDate,
            "status": item.status,
            "category": chain,
            "color": color_data
        })

    return ResponseEnvelope(
        status="success",
        data=[ItemWithDetail.model_validate(r) for r in result_items],
        message="조회 성공"
    )
