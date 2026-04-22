from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from datetime import datetime
from app.all_response import ResponseEnvelope,ErrorEnvelope

from app.lost_reports.schema import (
  UserItemCreate,
  UserItemResponse,
  UserItemUpdate,
  ClaimRequestResponse,
  CancelClaimResponse,
  CompleteClaimResponse,
  UpdateItemResponse,
  DeleteItemResponse
  
)
from app.lost_reports.service import (
  createItem,
  getItemById,
  getItemsByUserId,
  updateItem,
  deleteItem,
  requestClaim,
  cancelClaim,
  completeClaim,

)
from app.database.session import getDb
from app.auth.utils import getCurrentUser

router = APIRouter(prefix="/api/v1/my",tags=["Item"])

## 유저관련 기능
# 내 분실물 등록
@router.post(
      "/report/register", 
      response_model=ResponseEnvelope[UserItemResponse],
      responses={
          403: {
              "model": ErrorEnvelope,
              "description": "잘못된 파라미터"
          },
      },      
  )
def registerItem(
  item: UserItemCreate,
  db: Session = Depends(getDb),
  userId: int = Depends(getCurrentUser)
):
  created: UserItemResponse = createItem(item, userId, db)
  return ResponseEnvelope(
       status="success",
        data=created,
        message="개인 물품 등록 완료",
    )


# 내 분실물 목록 조회
@router.get("/report/list", 
            summary="내가 등록한 분실물 목록 조회",
            response_model=ResponseEnvelope[list[UserItemResponse]]
            )
def readMyItems(
  db: Session = Depends(getDb),
  userId: int = Depends(getCurrentUser)
):
  items=getItemsByUserId(userId, db)
  
  return ResponseEnvelope(
        status="success",
          data=items,
          message="내 분실물 목록 조회",
      )



# 내 분실물 상세 조회
@router.get(
    "/report/{item_id}",
    response_model=ResponseEnvelope[UserItemResponse],
    summary="내가 등록한 분실물 상세조회",
    description="로그인한 유저가 등록한 분실물 하나를 ID로 조회합니다."
)
def readItemById(
    item_id: int,
    db: Session = Depends(getDb),
    userId: int = Depends(getCurrentUser)
):
    itme=getItemById(item_id, userId, db)
    # service 레이어에서 권한검사 포함
    return ResponseEnvelope(
        status="success",
          data=itme,
          message=f"내 {item_id}분실물 상세 조회",
      )


@router.put(
    "/report/update/{item_id}",
    response_model=ResponseEnvelope[UpdateItemResponse],
    summary="내가 등록한 분실물 수정",
)
def updateItemById(
    item_id: int,
    itemData: UserItemUpdate,
    db: Session = Depends(getDb),
    userId: int = Depends(getCurrentUser),
):
    payload = updateItem(item_id, userId, itemData, db)
    return {
        "status": "success",
        "data": payload,
        "message": f"{item_id}번 분실물이 성공적으로 수정되었습니다."
    }

@router.delete(
    "/report/delete/{item_id}",
    response_model=ResponseEnvelope[DeleteItemResponse],
    summary="내가 등록한 분실물 삭제",
)
def deleteItemById(
    item_id: int,
    db: Session = Depends(getDb),
    userId: int = Depends(getCurrentUser),
):
    payload = deleteItem(item_id, userId, db)
    return {
        "status": "success",
        "data": payload,
        "message": f"{item_id}번 분실물이 성공적으로 삭제되었습니다."
    }

# 분실물 수령 요청
@router.post(
    "/pickup/claim/{item_id}",
    response_model=ResponseEnvelope[ClaimRequestResponse],
    summary="분실물 수령 요청",
)
def claimItem(
    item_id: int,
    db: Session = Depends(getDb),
    userId: int = Depends(getCurrentUser),
):
    payload = requestClaim(item_id, userId, db)
    return {
        "status": "success",
        "data": payload,
        "message": f"{item_id}번 분실물에 수령 요청을 보냈습니다."
    }

# 분실물 수령 요청 취소
@router.post(
    "/pickup/cancel/{item_id}",
    response_model=ResponseEnvelope[CancelClaimResponse],
    summary="분실물 수령 요청 취소",
)
def cancelItem(
    item_id: int,
    db: Session = Depends(getDb),
    userId: int = Depends(getCurrentUser),
):
    payload = cancelClaim(item_id, userId, db)
    return {
        "status": "success",
        "data": payload,
        "message": f"{item_id}번 분실물 수령 요청이 취소되었습니다."
    }

@router.post(
    "/pickup/complete/{item_id}",
    response_model=ResponseEnvelope[CompleteClaimResponse],
    summary="분실물 수령 완료",
)
def completeItem(
    item_id: int,
    db: Session = Depends(getDb),
    userId: int = Depends(getCurrentUser),
):
    payload = completeClaim(item_id, userId, db)
    return {
        "status": "success",
        "data": payload,
        "message": f"{item_id}번 분실물이 성공적으로 수령 완료되었습니다."
    }