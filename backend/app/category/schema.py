from pydantic import BaseModel

class CategoryResponse(BaseModel):
  id: int
  title: str
  parentId: int | None
  depth: int

  class Config:
    orm_mode = True
