# service.py
from sqlalchemy.orm import Session, joinedload
from sqlalchemy import or_, cast, String
from typing import Optional, List

from app.robot.model import Items
from app.category.model import Category
from app.color.model import Color

def getAllCategories(db: Session) -> List[Category]:
  return db.query(Category).all()

def getAllColors(db: Session):
  return [
    {
      "id": color.id,
      "colorName": color.colorName,
      "hexValue": color.hexValue
    }
    for color in db.query(Color).all()
  ]

def collectSubCategoryIds(category: Category) -> List[int]:
  ids = [category.id]
  for child in category.children:
    ids.extend(collectSubCategoryIds(child))
  return ids

def filterItemsByKeyword(
  db: Session,
  queryStr: Optional[str] = None,
  categoryId: Optional[int] = None,
  colorIds: Optional[List[int]] = None 
) -> List[Items]:
  query = db.query(Items).options(
    joinedload(Items.category),
    joinedload(Items.color)
  )

  filters = []

  if queryStr:
    like = f"%{queryStr}%"

    matchedCategories = db.query(Category).options(joinedload(Category.children)).filter(
      Category.title.ilike(like)
    ).all()
    categoryIds = []
    for cat in matchedCategories:
      categoryIds.extend(collectSubCategoryIds(cat))

    matchedColors = db.query(Color).filter(Color.colorName.ilike(like)).all()
    colorMatchedIds = [c.id for c in matchedColors]

    filters.append(
      or_(
        Items.title.ilike(like),
        Items.foundLocation.ilike(like),
        Items.status.ilike(like),
        cast(Items.registeredDate, String).ilike(like),
        Items.categoryId.in_(categoryIds) if categoryIds else False,
        Items.colorId.in_(colorMatchedIds) if colorMatchedIds else False
      )
    )

  if categoryId:
    category = db.query(Category).options(joinedload(Category.children)).filter(Category.id == categoryId).first()
    if category:
      subIds = collectSubCategoryIds(category)
      filters.append(Items.categoryId.in_(subIds))
    else:
      return []

  if colorIds:
    filters.append(Items.colorId.in_(colorIds))  

  if filters:
    query = query.filter(*filters)

  return query.order_by(Items.registeredDate.desc()).all()

def buildCategoryChain(allCategories: List[Category], categoryId: Optional[int]):
  categoryMap = {cat.id: cat for cat in allCategories}

  def buildUpwardChain(catId):
    cat = categoryMap.get(catId)
    if not cat:
      return None

    node = {
      "id": cat.id,
      "title": cat.title,
      "children": []
    }

    if cat.parentId:
      parent = buildUpwardChain(cat.parentId)
      if parent:
        parent["children"].append(node)
        return parent
    return node

  return buildUpwardChain(categoryId)
