from sqlalchemy.orm import Session
from app.color.model import Color

def getAllColors(db: Session):
  return db.query(Color).all()
