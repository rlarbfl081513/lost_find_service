from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.session import getDb
from app.color.service import getAllColors
from app.color.schema import ColorResponse
from app.all_response import ResponseEnvelope

router = APIRouter(prefix="/api/v1", tags=["Colors"])

@router.get("/colors", 
            response_model=ResponseEnvelope[list[ColorResponse]],
            summary="전체 색상 조회"
            )
def readAllColors(db: Session = Depends(getDb)):
  colors = getAllColors(db)
  return {
    "status": "success",
    "data": colors,
    "message": "색상 목록 조회 성공"  
  }