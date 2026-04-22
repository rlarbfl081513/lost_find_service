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


    db.close()
