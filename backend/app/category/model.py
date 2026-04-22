# app/category/model.py
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship, backref
from app.database.session import Base

class Category(Base):
  __tablename__ = "categories"

  id = Column(Integer, primary_key=True, index=True)
  title = Column(String(50), nullable=False)
  parentId = Column(Integer, ForeignKey("categories.id"), nullable=True)
  depth = Column(Integer, default=0)

  # 부모 카테고리 객체
  parent = relationship(
    "Category",
    remote_side=[id],
    backref=backref("children", lazy="joined"),
    foreign_keys=[parentId],
    lazy="joined"
  )
