# Context Persistence

프로젝트의 설계 결정과 명세는 반드시 파일로 남겨 Single Source of Truth로 유지한다.

## 규칙

- `/spec`으로 합의된 명세는 CLAUDE.md 또는 docs/spec.md에 저장한다
- `/plan`으로 합의된 구현 계획은 CLAUDE.md 또는 docs/plan.md에 저장한다
- `/init`에서 결정된 기술 스택은 CLAUDE.md에 기록한다
- 설계 변경이 생기면 해당 문서를 즉시 업데이트한다
- 새 세션 시작 시 CLAUDE.md를 먼저 읽고 맥락을 파악한다

## 참조 의무

- `/plan` 실행 시: spec 문서 참조
- `/continue` 실행 시: spec + plan 문서 참조
- `/verify` 실행 시: spec 문서 대비 대조
- 코딩 중: 설계 결정과 다른 방향으로 구현하지 않는다
