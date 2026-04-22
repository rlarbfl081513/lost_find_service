from pydantic import BaseModel

class ColorResponse(BaseModel):
  id: int
  colorName: str
  hexValue: str

  class Config:
    orm_mode = True
