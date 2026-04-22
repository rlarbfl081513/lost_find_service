# app/database/init_db.py

# from app.database.session import engine
# from app.user.model import User
# from app.lost_reports.model import LostReports
# from app.database.session import Base

# def initDb():
#     Base.metadata.create_all(bind=engine)


# init_db.py (또는 별도 seed 파일에 넣어도 좋습니다)

from sqlalchemy.orm import Session
from app.database.session import engine, SessionLocal
from app.robot.model import Items
from app.database.session import Base
from datetime import datetime

def initDb():
    Base.metadata.create_all(bind=engine)
    db: Session = SessionLocal()

    # if not db.query(Items).first():  # 중복 생성 방지
    #     dummy_items = [
    #         Items(
    #             title="아이폰 13 프로",
    #             category="스마트폰",
    #             color="그라파이트",
    #             image_url="https://yo9i-image.s3.ap-northeast-2.amazonaws.com/items/item01.jpg",
    #             slot_id=1,
    #             found_location="도서관",
    #             robot_number=101,
    #             extra_info="뒤에 스티커 있음",
    #             registered_time=datetime.strptime("2025-07-29", "%Y-%m-%d").date()
    #         ),
    #         Items(
    #             title="검정색 지갑",
    #             category="지갑",
    #             color="검정",
    #             image_url="https://yo9i-image.s3.ap-northeast-2.amazonaws.com/items/item02.jpg",
    #             slot_id=2,
    #             found_location="카페테리아",
    #             robot_number=102,
    #             extra_info="카드 여러 장 있음",
    #             registered_time=datetime.strptime("2025-07-28", "%Y-%m-%d").date()
    #         ),
    #         Items(
    #             title="무선 이어폰",
    #             category="이어폰",
    #             color="하얀색",
    #             image_url="https://yo9i-image.s3.ap-northeast-2.amazonaws.com/items/item03.jpg",
    #             slot_id=3,
    #             found_location="강의실 A103",
    #             robot_number=103,
    #             extra_info="왼쪽 귀 안 들림",
    #             registered_time=datetime.strptime("2025-07-31", "%Y-%m-%d").date()
    #         ),
    #         Items(
    #             title="필통",
    #             category="기타",
    #             color="파랑",
    #             image_url="https://yo9i-image.s3.ap-northeast-2.amazonaws.com/items/item04.jpg",
    #             slot_id=4,
    #             found_location="자습실",
    #             robot_number=104,
    #             extra_info="네임택 부착되어 있음",
    #             registered_time=datetime.strptime("2025-08-01", "%Y-%m-%d").date()
    #         ),
    #         Items(
    #             title="갤럭시 Z 플립",
    #             category="스마트폰",
    #             color="퍼플",
    #             image_url="https://yo9i-image.s3.ap-northeast-2.amazonaws.com/items/item05.jpg",
    #             slot_id=5,
    #             found_location="정문 입구",
    #             robot_number=105,
    #             extra_info="충전 10% 미만",
    #             registered_time=datetime.strptime("2025-08-03", "%Y-%m-%d").date()
    #         ),
    #     ]

    #     db.add_all(dummy_items)
    #     db.commit()

    db.close()
