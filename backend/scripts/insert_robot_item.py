import os, json
from datetime import datetime
from sqlalchemy.orm import Session
from app.database.session import SessionLocal
from app.robot.model import Items

def insert_items_from_json_with_local_images():
    db: Session = SessionLocal()

    # 스크립트 파일이 있는 폴더
    script_dir = os.path.dirname(__file__)
    # JSON 파일도 같은 폴더 안에 있다고 가정
    json_path = os.path.join(script_dir, "robot_items_dummy.json")
    # 이미지 폴더도 스크립트 기준으로
    images_dir = os.path.join(script_dir, "item_image")

    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    for entry in data:
        filename = os.path.basename(entry["imageUrl"])
        local_path = os.path.join(images_dir, filename)

        if not os.path.exists(local_path):
            raise FileNotFoundError(f"이미지 파일이 없습니다: {local_path}")

        item = Items(
            title=entry["title"],
            imageUrl=local_path,
            slotId=entry["slotId"],
            status=entry["status"],
            foundLocation=entry["foundLocation"],
            registeredDate=datetime.strptime(entry["registeredDate"], "%Y-%m-%d").date(),
            robotNumber=entry["robotNumber"],
            categoryId=entry["categoryId"],
            colorId=entry["colorId"],
            robotNumberId=None,
            extraInfo=None
        )
        db.add(item)

    db.commit()
    db.close()
    print("✅ 로컬 이미지 경로로 아이템 삽입 완료")

if __name__ == "__main__":
    insert_items_from_json_with_local_images()
