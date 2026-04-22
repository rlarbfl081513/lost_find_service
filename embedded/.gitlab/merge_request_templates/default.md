<!-- 제목 : feat(Jira 코드/issue 코드): 기능 내용 -->
### Part
- [ ] Front-end
- [ ] Back-end
- [ ] Data
- [ ] AI
- [O] Hardware
- [ ] CI/CD
- [ ] Other

### PR 타입(하나 이상의 PR 타입을 선택해주세요)
- [O] Feat : 새로운 기능 추가
- [ ] Bug : 버그 발견
- [ ] Fix : 버그 수정
- [ ] Docs : 문서 수정
- [ ]  Style : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
- [ ] Refactor : 코드 리펙토링

### 반영 브랜치
ex) feature-linetrace-chatbot -> embed

### 작업 내용
- 카메라에서 라인을 detect하고, 라인이 치우친 정도에 따라 조향각 조절하는 라인 트레이싱
- 트리거 단어에 따라 요기 서비스를 소개하는 음성 출력하는 코드 작성
- 화면에 요기 얼굴을 띄우다가 백엔드에서 신호를 받으면 사진 촬영 후 사진 전송
- 사용자 인증 완료 신호를 받으면 라즈베리파이 -> 아두이노로 신호 전송
- 물건 넣을 때 초음파 센서와의 거리가 연속 3번 이상 18.5cm 이하가 되면 사진 촬영 후 백엔드에 전송, 자동문 열리도록 아두이노에 신호 전송


### 테스트 결과
ex) 
사진 첨부
<img src="![alt text](../../jetson_orin_nano/image_line_trace.png)">
<img src="![alt text](../../raspberrypi4/image_chatbot.png)">
<img src="![alt text](<../../요기 최종.jpg>)">

### 지라 링크
- [S13P11A105-39](https://ssafy.atlassian.net/browse/S13P11A105-39)
- [S13P11A105-199](https://ssafy.atlassian.net/browse/S13P11A105-199)
- [S13P11A105-265](https://ssafy.atlassian.net/browse/S13P11A105-265)
- [S13P11A105-266](https://ssafy.atlassian.net/browse/S13P11A105-266)
- [S13P11A105-267](https://ssafy.atlassian.net/browse/S13P11A105-267)
