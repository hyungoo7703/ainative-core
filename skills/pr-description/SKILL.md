---
name: pr-description
description: PR 작성 가이드. Pull Request 생성, PR 설명 작성 시 자동 활성화.
---

PR은 리뷰어가 빠르게 이해할 수 있도록 작성합니다.

## PR 제목
- 70자 이내
- Conventional Commits 형식: `feat: 기능 설명` / `fix: 버그 설명`
- "what"이 아닌 "why" 중심

## PR 본문 템플릿

```markdown
## 요약
(1~3줄로 이 PR이 무엇을 왜 하는지)

## 변경 사항
- (주요 변경 1)
- (주요 변경 2)

## 스크린샷
(UI 변경이 있으면 before/after)

## 테스트
- [ ] 단위 테스트 추가/수정
- [ ] 수동 테스트 완료
- [ ] 기존 테스트 통과 확인

## 체크리스트
- [ ] 코드 셀프 리뷰 완료
- [ ] 불필요한 console.log 제거
- [ ] 관련 문서 업데이트 (해당 시)
```

## 원칙
- 하나의 PR에 하나의 목적
- PR이 크면 쪼갠다 (리뷰어 부담 감소)
- Draft PR을 활용하여 조기 피드백
