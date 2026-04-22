# 여기 있잖아
> 찾고 있던 그 물건, <br />
> **여기 있잖아!**

## 개발 흐름 (GitFlow)
1. Git Repository Fork
2. 새로운 브랜치 생성
    - 기능 구현 : `(part)/feature-(function)`
        - ex) `front/feature-homepage`
        - `(part)/dev` 브랜치 에서 복제
    - 핫 픽스 : `(part)/hotfix-(function)`
        - `(part)/master` 브랜치 에서 복제
    - 릴리즈 : `(part)/relese-(version)`
        - ex) `front/relese-1.0v`
        - `(part)/dev` 브랜치 에서 복제
3. Jira Issue 확인
4. Git Issue 생성
5. 개발 진행
6. commit
    - 작업 별로 commit 진행
    - commit message 는 커밋 컨벤션에 따름
    - 참고 링크 : https://silent-wednesday-ad8.notion.site/230083ee0c9c80aa8343c0a44a89c63d
    ```plaintext
    type(issue 번호): 간단한 내용 정리 // 제목

    // 본문
    - 기능 별 수정사항 작성(수정 파일명 등 참고 데이터)
    - 수정한 내용은 '-'로 구분 하여 작성성

    // 꼬리말
    Resolevs: #1
    ```
    - 자주 사용하는 type
        - feat: 새로운 기능 구현
        - fix: 버그 수정
        - refact : 코드 리팩토링(기능 수정)
        - design : UI 변경
        - comment : 주석 추가 및 수정
        - docs : 문서 수정
        - test : 테스트 추가 및 테스트 리펙토링
        - style : 오타, 탭사이즈, 변수명 변경 등
        - chore : 빌드 or 패키지 매니징 수정 사항
7. 테스트 완료(*필요시)
8. `(part)/dev` merge request 요청
9. **코드 리뷰(반드시!!!)**
10. 기본적으로는 평일 오후 5시 30분 일괄 Merge
    - 특별한 사항 없는 경우 개인이 Merge 하지 않음
    - 각 파트별 메인 개발자가 Merge 하거나 팀장이 Merge 진행
11. 생성한 브랜치 삭제
> 추후 MVP 나올 때 `(part)/master` 브랜치로 Merge
