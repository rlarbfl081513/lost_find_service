# app/schemas/response.py
from pydantic import BaseModel, Field
from typing import Any, List, Dict, Literal, Generic, TypeVar

T = TypeVar("T")

class ResponseEnvelope(BaseModel, Generic[T]):
    status:  str    = Field(..., description="응답 상태 (e.g. success / error)")
    data:    T      = Field(..., description="실제 페이로드 (단일 객체 혹은 리스트)")
    message: str    = Field(..., description="추가 설명 메시지")

    class Config:
        # Pydantic V2: orm_mode 대신 from_attributes
        from_attributes = True


# ── 1) errors 배열 안에 어떤 객체들이 들어가는지 정의
class ErrorItem(BaseModel):
    code:    str  = Field(..., description="에러 식별 코드")
    message: str  = Field(..., description="에러 상세 메시지")
    # 만약 추가 필드가 있으면 여기에 더 정의


# ── 2) errors, meta, clerk_trace_id 를 묶는 디테일 모델
class ErrorDetail(BaseModel):
    errors:        List[ErrorItem]   = Field(..., description="에러 항목 배열")
    meta:          Dict[str, Any]    = Field(..., description="메타 정보")
    # clerk_trace_id: str              = Field(..., description="Clerk 추적 ID")


# ── 3) Envelope 형태로 감싸기
class ErrorEnvelope(BaseModel):
    status:  Literal["error"]        = Field("error")
    data:    ErrorDetail             = Field(..., description="에러 상세 정보")
    message: str                     = Field(..., description="사용자용 에러 메시지")

    class Config:
        from_attributes = True