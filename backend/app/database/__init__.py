from app.database.session import Base, engine

# 모든 모델 import (❗️중요: 테이블 생성을 위해 필요함)
from app.robot.model import Items
from app.lost_reports.model import LostReports
from app.slot.model import Slot
from app.idcard.model import IDCard
from app.retrieval_log.model import RetrievalLog
from app.color.model import Color
from app.category.model import Category
from app.robot_number.model import RobotNumber
from app.robot_spots.model import RobotSpots
from app.recommend_search.model import RecommendSearch
from app.user.model import User

def initDb():
  # Base가 추적하는 모든 모델 테이블을 생성
  Base.metadata.create_all(bind=engine)
  print("✅ 모든 DB 테이블 생성 완료")
