from sqlalchemy import Table, Column, Integer, ForeignKey
from app.database.session import Base

lost_report_item_connection = Table(
    "lost_report_item_connection", 
    Base.metadata,
    Column("report_id",Integer, ForeignKey("lost_reports.id"),primary_key=True),
    Column("item_id",Integer, ForeignKey("items.id"),primary_key=True)
    )