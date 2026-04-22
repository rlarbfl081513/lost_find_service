# 요기 (YOGI) — 한강 분실물 로봇 수거 서비스

> 한강에서 습득된 분실물을 자율주행 로봇이 수거하고, 분실자가 앱에서 확인 후 얼굴 인식으로 수령하는 IoT 기반 분실물 관리 서비스

---

## 목차

- [서비스 소개](#서비스-소개)
- [담당 역할](#담당-역할)
- [기술 스택](#기술-스택)
- [주요 구현 내용](#주요-구현-내용)
- [서비스 흐름](#서비스-흐름)
- [실행 방법](#실행-방법)

---

## 서비스 소개

한강에서 분실물을 주운 시민이 자율주행 로봇을 호출해 물건을 보관하면, 카메라 AI가 물건을 인식·등록하고, 분실자는 앱에서 해당 물건을 확인 후 로봇과 약속 스팟에서 만나 얼굴 인식으로 본인 확인 후 수령하는 서비스입니다.

**팀 구성** : 총 6인 (프론트엔드 1 · 백엔드 2 · 인프라 1 · 임베디드 1)

---

## 담당 역할

**백엔드 개발** (백엔드 2인 중 1인)

| 구분 | 담당 기능 |
|------|----------|
| 분실물 신고 API | 분실물 등록 / 수정 / 삭제 / 조회 CRUD 전체 |
| 수령 워크플로우 | 수령 요청 → 취소 → 완료 상태 흐름 설계 및 구현 |
| 매칭 시스템 | 신고된 분실물과 로봇 등록 아이템 간 M2M 연결 구조 설계 |
| 카테고리 시스템 | 3단계 계층형 카테고리 트리 구조 설계 및 API |
| DB 시딩 스크립트 | 카테고리·색상·추천 검색어 초기 데이터 구성 |

> 로그인(OAuth) · 검색 기능은 팀원 담당

---

## 기술 스택

### Backend
| 기술 | 버전 |
|------|------|
| Python | 3.11 |
| FastAPI | 0.115 |
| SQLAlchemy | 2.0 |
| Pydantic | V2 |
| Authlib | (Kakao OAuth2) |
| python-jose | JWT |
| SQLite | (개발 환경) |

### Frontend
| 기술 | 설명 |
|------|------|
| Flutter | 크로스플랫폼 모바일 앱 |

### Embedded
| 장비 | 역할 |
|------|------|
| Raspberry Pi 5 | 얼굴 인식 카메라 · 디스플레이 · WebSocket 통신 |
| Raspberry Pi 4 | 로봇 챗봇 인터페이스 |
| Jetson Orin Nano | 자율주행 라인 트레이싱 |
| Arduino | 모터 제어 |

---

## 주요 구현 내용

### 1. 분실물 신고 · 수령 상태 머신

```
등록 → 수령대기 → 완료
```

단순 boolean 대신 상태값(`status`)으로 흐름을 관리했습니다. 수령 요청 시 해당 아이템은 즉시 `수령대기`로 전환되어 중복 수령 요청을 방지하고, 취소 시 `등록` 상태로 되돌아가도록 설계했습니다. 이를 통해 별도의 락(lock) 없이 동시 수령 요청 충돌을 방지했습니다.

### 2. 로봇 아이템 ↔ 분실 신고 M2M 매칭 구조

```
LostReports ──< lost_report_item_connection >── Items(Robot)
```

로봇이 등록한 아이템(`Items`)과 사용자가 신고한 분실물(`LostReports`)을 별도 테이블로 분리하고 M2M 조인 테이블로 연결했습니다. 하나의 습득물이 여러 신고 건과 매칭될 수 있는 현실적인 시나리오(예: 두 사람이 같은 지갑을 잃어버렸다고 신고)를 모델로 표현하기 위해서입니다.

### 3. 3단계 계층형 카테고리 트리

```python
Category(id, title, parentId, depth)  # self-referential FK
```

카테고리 depth를 고정하지 않고 self-referential 구조로 설계해 확장성을 확보했습니다. API 응답 시 `getCategoryPath_list()`로 leaf → root 방향으로 경로를 역추적한 뒤, `buildCategoryTreeFromPath()`로 중첩 트리 형태로 재조립해 프론트엔드가 별도 조인 없이 전체 트리를 한 번에 사용할 수 있도록 했습니다.

### 4. 전역 응답 Envelope 설계

```python
ResponseEnvelope[T]  →  { status, data: T, message }
ErrorEnvelope        →  { status, data: { errors, meta, clerk_trace_id }, message }
```

성공·실패 응답 포맷을 단일 구조로 통일해 프론트엔드가 응답 처리 로직을 하나로 가져갈 수 있도록 했습니다. Pydantic V2 제네릭으로 구현해 타입 안전성을 유지했고, 전역 exception handler에 UUID 기반 trace_id를 심어 디버깅 추적이 가능하도록 했습니다.

### 5. 관리자 전용 만료 아이템 조회

```python
@router.get("/items/expired")
# 7일 이상 보관된 미수령 아이템 자동 조회
```

보관 공간 관리를 위해 등록 후 7일이 지난 미수령 아이템을 자동으로 필터링하는 관리자 전용 엔드포인트를 구현했습니다. 운영자가 주기적으로 재처리 또는 폐기 결정을 내릴 수 있도록 했습니다.

### 6. 로봇 하드웨어 신호 API

```python
POST /api/v1/hardware/send-signal/{num}
```

백엔드가 로봇 하드웨어에 직접 신호를 전달하는 pass-through 엔드포인트입니다. 앱 → 백엔드 → 로봇의 단방향 명령 흐름을 HTTP로 추상화해, 앱이 로봇의 내부 통신 방식을 알 필요 없도록 결합도를 낮췄습니다.

---

## 서비스 흐름

```
[시민이 물건 습득]
      ↓
앱에서 로봇 호출 → 로봇 이동 → 보관함에 물건 적재
      ↓
라즈베리파이5 카메라로 물건 촬영 → 백엔드 아이템 자동 등록
      ↓
[분실자가 앱에서 물건 확인 → 수령 요청]
      ↓
앱에서 약속 스팟 선택 → 로봇 이동
      ↓
라즈베리파이5 얼굴 인식 → 신원 확인 → 보관함 잠금 해제
      ↓
[분실자 물건 수령 완료]
```

---

## 실행 방법

### 환경 변수 설정

`backend/` 디렉토리에 `.env` 파일을 생성합니다.

```env
JWT_SECRET_KEY=your_jwt_secret
JWT_REFRESH_SECRET_KEY=your_refresh_secret
SESSION_SECRET_KEY=your_session_secret
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7

KAKAO_CLIENT_ID=your_kakao_client_id
KAKAO_CLIENT_SECRET=your_kakao_client_secret

ADMIN_USERNAME=admin
ADMIN_PASSWORD=your_admin_password
ADMIN_CONTACT=admin@example.com

HARDWARE_URL=http://your_hardware_ip:8765
```

### 백엔드 실행

```bash
cd backend
pip install -r requirements.txt

# DB 초기 데이터 세팅
python -m scripts.insert_categories
python -m scripts.insert_colors
python -m scripts.insert_recommend_search
python -m scripts.create_admin

# 서버 실행
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### 프론트엔드 실행

```bash
cd frontend/client
flutter pub get
flutter run
```

### 임베디드 실행

각 장비별 실행 스크립트는 `embedded/` 디렉토리 내 README를 참고하세요.

| 장비 | 실행 파일 |
|------|----------|
| Raspberry Pi 5 (카메라) | `embedded/raspberrypi5/face_camera_show_display.py` |
| Raspberry Pi 5 (감지) | `embedded/raspberrypi5/detect_product_open_door.py` |
| Raspberry Pi 4 | `embedded/raspberrypi4/chatbot.py` |
| Jetson Orin Nano | `embedded/jetson_orin_nano/line_tracing.py` |
| Arduino | `embedded/arduino/arduino_motor.ino` |
