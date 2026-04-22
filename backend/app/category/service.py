from sqlalchemy.orm import Session
from app.category.model import Category

def getAllCategories(db: Session):
  return db.query(Category).all()
