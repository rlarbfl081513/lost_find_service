# main.py

from dotenv import load_dotenv
from pathlib import Path
import os
# main.py 최상단
env_path = Path(__file__).resolve().parent.parent / ".env"
load_dotenv(dotenv_path=env_path)

from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError
from uuid import uuid4
from app.all_response import ErrorEnvelope,ErrorDetail,ErrorItem


app = FastAPI(
    swagger_ui_parameters={
        "validatorUrl": None  # 외부 스키마 검증 서비스 끄기
    },
    responses={  # 전체 API에 공통으로 적용
    401: {"model": ErrorEnvelope, "description": "인증 실패"},
    403: {"model": ErrorEnvelope, "description": "권한 없음"},
    422: {"model": ErrorEnvelope, "description": "입력 검증 실패"},
    500: {"model": ErrorEnvelope, "description": "서버 오류"},
  }
)

@app.exception_handler(HTTPException)
async def http_exc_handler(request, exc):
    # 상태 코드별 기본 메시지
    default_messages = {
        401: "인증 필요",
        403: "권한 없음",
        422: "입력 검증 실패",
        500: "서버 오류"
    }
    msg = default_messages.get(exc.status_code, str(exc.detail))
    payload = ErrorEnvelope(
        status="error",
        data=ErrorDetail(
            errors=[ErrorItem(code=str(exc.status_code), message=msg)],
            meta={},
            clerk_trace_id="xyz-123"
        ),
        message=msg
    ).dict()
    return JSONResponse(status_code=exc.status_code, content=payload)


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    trace_id = str(uuid4())
    items = [ ErrorItem(code=e["type"], message=e["msg"]) for e in exc.errors() ]
    detail = ErrorDetail(errors=items, meta={}, clerk_trace_id=trace_id)
    envelope = ErrorEnvelope(status="error", data=detail, message="입력값이 유효하지 않습니다.")
    return JSONResponse(status_code=422, content=envelope.dict())

from fastapi.responses import JSONResponse
from starlette.middleware.sessions import SessionMiddleware
from app.auth.router import router as authRouter
from app.user.router import router as userRouter
from app.lost_reports.router import router as lostReportRouter
from app.items.router import router as itemRouter
from app.database.init_db import initDb
from app.admin import router as adminRouter
from app.recommend_search.router import router as recommendSearchRouter
from app.color.router import router as colorRouter
from app.category.router import router as categoryRouter
from scripts.hardware_test import router as hardWareRouter
from uuid import uuid4
from app.search.router import router as searchRouter


@app.get("/")
def health_check():
    return {"status": "ok"}

# DB 초기화.
initDb()

app.add_middleware(SessionMiddleware, secret_key=os.getenv("SESSION_SECRET_KEY", ""))

# 라우터 등록
app.include_router(authRouter)
app.include_router(userRouter)
app.include_router(lostReportRouter)
app.include_router(itemRouter)
app.include_router(adminRouter.router)
app.include_router(recommendSearchRouter)
app.include_router(colorRouter)
app.include_router(categoryRouter)
app.include_router(hardWareRouter)
app.include_router(searchRouter)
