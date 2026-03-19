# TypeScript Rules

> 이 규칙은 TypeScript 프로젝트에서만 적용합니다.

## 타입 시스템
- `any` 사용 금지 — `unknown`을 쓰고 타입 가드로 좁힌다
- `strict: true` 필수
- 타입 추론이 가능한 곳에서 불필요한 타입 선언 생략
- `as` 타입 단언 최소화 — 타입 가드 우선

## 패턴
- `enum` 대신 `as const` 객체 사용
- `interface`는 확장 가능한 객체 타입에, `type`은 유니온/유틸리티에
- Optional chaining(`?.`)과 nullish coalescing(`??`) 활용
- `!` non-null assertion 금지 — 조건문으로 좁힌다

## 함수
- 반환 타입은 복잡한 함수에만 명시 (단순한 것은 추론에 맡긴다)
- 매개변수 3개 초과 시 객체로 받는다
- `async/await` 사용 — `.then()` 체이닝 지양

## import
- 타입 전용 import는 `import type` 사용
- 절대 경로 alias 설정 (`@/` 등)
- 사용하지 않는 import 제거
