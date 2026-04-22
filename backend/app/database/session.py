# app/database/session.py

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# DATABASE_URL = "postgresql://postgres:yogiyo9i@yogi-rdb.cxm80uoki4tl.ap-northeast-2.rds.amazonaws.com:5432/yogi_psql"

DATABASE_URL ="sqlite:///./lost_found.db"
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False)
Base = declarative_base()



def getDb():
  db = SessionLocal()
  try:
    yield db
  finally:
    db.close()
