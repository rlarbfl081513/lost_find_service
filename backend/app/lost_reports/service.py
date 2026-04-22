# app/item/service.py

from sqlalchemy.orm import Session
from app.lost_reports.model import LostReports
from app.lost_reports.schema import DeleteItemResponse,UpdateItemResponse,CompleteClaimResponse,CancelClaimResponse, UserItemResponse,UserItemCreate,UserItemUpdate,ClaimRequestResponse
from fastapi import HTTPException
from app.robot.model import Items
from datetime import datetime
from sqlalchemy.exc import SQLAlchemyError

# 특정 분실물 조회
def getItemById(itemId: int, userId: int, db: Session) -> LostReports:
    item = db.query(LostReports).filter(LostReports.id == itemId).first()
    if not item:
        raise HTTPException(status_code=404, detail="분실물이 존재하지 않습니다.")
    if item.userId != userId:
        raise HTTPException(status_code=403, detail="조회 권한이 없습니다.")
    return item

# 특정 사용자의 분실물 조회
def getItemsByUserId(userId: int, db: Session):
  return db.query(LostReports).filter(LostReports.userId == userId).all()


# 내 분실물 등록
def createItem(
    item: UserItemCreate,
    userId: int,
    db: Session
) -> UserItemResponse:
    # 필수 입력 값 확인
    if not item.category or item.category.strip() == "":
        raise HTTPException(status_code=400, detail="카테고리는 필수 입력 항목입니다.")

    try:
        new_report = LostReports(
            description=item.description,
            category=item.category,
            color=item.color,
            status="등록",
            createdAt=datetime.utcnow(),
            userId=userId
        )
        db.add(new_report)
        db.commit()
        db.refresh(new_report)

        # Pydantic v2: model_validate 로 직렬화된 Pydantic 모델을 반환
        return UserItemResponse.model_validate(new_report)

    except SQLAlchemyError:
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail="서버 내부 오류로 분실물 등록에 실패했습니다. 잠시 후 다시 시도해주세요."
        )

# 내 분실물 조회
def getAllMyItems(db: Session):
  return db.query(LostReports).all()

def updateItem(
    itemId: int,
    userId: int,
    itemData: UserItemUpdate,
    db: Session
) -> UpdateItemResponse:
    item = db.query(LostReports).filter(LostReports.id == itemId).first()
    if not item:
        raise HTTPException(status_code=404, detail="분실물이 존재하지 않습니다.")
    if item.userId != userId:
        raise HTTPException(status_code=403, detail="수정 권한이 없습니다.")

    updateData = itemData.dict(exclude_unset=True)
    for key, value in updateData.items():
        setattr(item, key, value)

    try:
        db.commit()
        db.refresh(item)
        return UpdateItemResponse.model_validate(item)
    except SQLAlchemyError:
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail="서버 오류로 분실물 수정에 실패했습니다."
        )

def deleteItem(itemId: int, userId: int, db: Session) -> DeleteItemResponse:
    item = db.query(LostReports).filter(LostReports.id == itemId).first()
    if not item:
        raise HTTPException(status_code=404, detail="해당 분실물이 존재하지 않습니다.")
    if item.userId != userId:
        raise HTTPException(status_code=403, detail="삭제 권한이 없습니다.")

    try:
        deleted_id = item.id
        db.delete(item)
        db.commit()
        return DeleteItemResponse(id=deleted_id)
    except SQLAlchemyError:
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail="서버 오류로 분실물 삭제에 실패했습니다."
        )

# 수령 요청 처리
def requestClaim(itemId: int, userId: int, db: Session) -> ClaimRequestResponse:
    item = db.query(LostReports).filter(
        LostReports.id == itemId,
        LostReports.userId == userId,
        LostReports.status == "등록"
    ).first()
    if not item:
        raise HTTPException(status_code=404, detail="해당 분실물이 없거나 요청할 수 없는 상태입니다.")

    item.status = "수령대기"
    try:
        db.commit()
        db.refresh(item)
        return ClaimRequestResponse.model_validate(item)
    except SQLAlchemyError:
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail="서버 내부 오류로 수령 요청을 처리하지 못했습니다."
        )

# 수령 취소 및 실패 처리
def cancelClaim(itemId: int, userId: int, db: Session) -> CancelClaimResponse:
    item = db.query(LostReports).filter(
        LostReports.id == itemId,
        LostReports.userId == userId,
        LostReports.status == "수령대기"
    ).first()
    if not item:
        raise HTTPException(status_code=404, detail="취소할 수령 요청이 없습니다.")
    item.status = "등록"
    try:
        db.commit()
        db.refresh(item)
        return CancelClaimResponse.model_validate(item)
    except SQLAlchemyError:
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail="서버 내부 오류로 수령 요청 취소에 실패했습니다."
        )

def completeClaim(itemId: int, userId: int, db: Session) -> CompleteClaimResponse:
    item = db.query(LostReports).filter(
        LostReports.id == itemId,
        LostReports.userId == userId,
        LostReports.status == "수령대기"
    ).first()
    if not item:
        raise HTTPException(status_code=404, detail="완료할 수령 요청이 없습니다.")
    item.status = "완료"
    try:
        db.commit()
        db.refresh(item)
        return CompleteClaimResponse.model_validate(item)
    except SQLAlchemyError:
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail="서버 내부 오류로 수령 완료 처리에 실패했습니다."
        )