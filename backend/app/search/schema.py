# schema.py

from pydantic import BaseModel
from typing import List, Optional
from datetime import date

class CategoryNode(BaseModel):
    id: int  
    title: str
    children: List["CategoryNode"] = []

    model_config = {"from_attributes": True}

CategoryNode.update_forward_refs()

class ColorOption(BaseModel):
    id: int  
    colorName: str
    hexValue: str

    model_config = {"from_attributes": True}

class ItemWithDetail(BaseModel):
    id: int  
    title: str
    foundLotation: str  # renamed to camelCase
    registeredDate: date
    status: str
    category: Optional[CategoryNode]
    color: Optional[ColorOption]

    model_config = {"from_attributes": True}

class SearchFullResponse(BaseModel):
    status: str
    data: List[ItemWithDetail]
    message: str

    model_config = {"from_attributes": True}