from pydantic import BaseModel

class RecommendSearchResponse(BaseModel):
  id: int
  searchKeyword: str

  class Config:
    orm_mode = True
