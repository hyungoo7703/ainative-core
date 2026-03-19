# Git Convention

- Conventional Commits 형식을 따른다
  - `feat:` 새 기능
  - `fix:` 버그 수정
  - `refactor:` 리팩토링
  - `docs:` 문서
  - `chore:` 빌드, 설정 등 기타
  - `test:` 테스트
- 커밋 메시지는 소문자로 시작, 마침표 없음
- 한 커밋에 한 가지 변경만 담는다
- 브랜치명: `feat/xxx`, `fix/xxx`, `chore/xxx`

## PR 및 머지 규칙

- PR 머지는 사용자가 직접 한다 (Claude가 임의로 머지 금지)
- 병렬 작업으로 PR이 여러 개인 경우:
  1. Claude가 하나의 통합 브랜치에 머지하고 충돌 해결
  2. 통합 브랜치로 PR 생성
  3. 사용자가 검토 후 머지
