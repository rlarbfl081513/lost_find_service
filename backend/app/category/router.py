from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.session import getDb
from app.category.model import Category
from app.category.utils import buildCategoryTree

router = APIRouter(prefix="/api/v1/categories", tags=["Category"])

@router.get("/tree")
def getCategoryTree(db: Session = Depends(getDb)):
  categories = db.query(Category).all()
  tree = buildCategoryTree(categories)
  return tree
