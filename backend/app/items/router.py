from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from app.robot.schema import LatestRobotItemResponse,DetialRobotItemResponse
from typing import List
from uuid import uuid4
from app.category.model import Category
from app.robot.model import Items
from app.all_response import ResponseEnvelope,ErrorEnvelope
from app.items.service import (
  getLatestRobotItems,
  getCategoryPath_list,
  buildCategoryTreeFromPath
)
from app.database.session import getDb

router = APIRouter(prefix="/api/v1/item",tags=["Item"])

# 최근 분실물 조회 
@router.get(
    "/list/latest",
    response_model=ResponseEnvelope[List[LatestRobotItemResponse]],
    summary="최신 분실물 5건 조회",
    description="등록일 기준 최신 순으로 최대 5건의 분실물을 조회합니다.",
    responses={
        404: {"model": ErrorEnvelope, "description": "등록된 분실물이 없습니다."},
    },
)
def get_latest_items(
    db: Session = Depends(getDb)
):
    items = getLatestRobotItems(db, limit=5)
    if not items:
        raise HTTPException(status_code=404, detail="등록된 분실물이 없습니다.")
    return ResponseEnvelope(
        status="success",
        data=items,
        message=f"최신 분실물 {len(items)}건 조회 성공"
    )


# 특정 분실물 상세 조회
@router.get("/detail/{item_id}", 
    response_model=ResponseEnvelope[DetialRobotItemResponse],
    summary="특정 분실물 조회",
    responses={
        404: {"model": ErrorEnvelope, "description": "등록된 분실물이 없습니다."},
    },
    )
def read_item(item_id: int, db: Session = Depends(getDb)):
    item = (
        db.query(Items)
        .options(joinedload(Items.category).joinedload(Category.parent))
        .filter(Items.id == item_id)
        .first()
    )
    if not item:
        raise HTTPException(404, "등록된 분실물이 없습니다.")

    path = getCategoryPath_list(item.category)
    category_tree = buildCategoryTreeFromPath(path)

    item = DetialRobotItemResponse(
                    id=item.id,
                    title=item.title,
                    imageUrl=item.imageUrl,
                    category=category_tree,
                    foundLocation=item.foundLocation,
                    registeredDate=item.registeredDate)
    
    return ResponseEnvelope(
                status="success",
                data=item,
                message="상세 조회 성공"
            )


# 홈화면 바로가기 버튼
# @router.get("/shortcut-categories", 
#     response_model=ResponseEnvelope[List[ShortcutCategory]],
#     summary="바로가기 카테고리 버튼",
#     )
# def GetShortcutCategory(db: Session = Depends(getDb)):
#     categories = db.query(Category).filter(Category.parentId == None).all()
#     result = []
#     for cat in categories:
#         result.append(ShortcutCategory(id=cat.id, title=cat.title, depth=cat.depth))
#     return ResponseEnvelope(
#                 status="success",
#                 data=result,
#                 message="바로가기 카테고리 버튼"
#             )