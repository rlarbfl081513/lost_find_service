from authlib.integrations.starlette_client import OAuth
from dotenv import load_dotenv
import os

load_dotenv()

oauth = OAuth()

oauth.register(
    name="kakao",
    client_id=os.getenv("KAKAO_CLIENT_ID"),
    client_secret=os.getenv("KAKAO_CLIENT_SECRET", ""),
    access_token_url="https://kauth.kakao.com/oauth/token",
    authorize_url="https://kauth.kakao.com/oauth/authorize",
    api_base_url="https://kapi.kakao.com",
    # ✅ scope: 카카오는 'profile' 또는 'profile_nickname' / 'account_email' 조합 사용
    client_kwargs={"scope": "account_email profile_nickname"},
    # ✅ 혹시 모를 구현 차이 대비: 본문에 확실히 넣어줌
    access_token_params={
        "client_id": os.getenv("KAKAO_CLIENT_ID"),
        "client_secret": os.getenv("KAKAO_CLIENT_SECRET", ""),
    },
)
