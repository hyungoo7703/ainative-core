---
name: error-handling
description: 에러 처리 패턴 가이드. try-catch, 에러 핸들링 코드 작성 시 자동 활성화.
---

에러는 적절한 위치에서, 적절한 방식으로 처리합니다.

## 어디서 잡을 것인가

| 위치 | 처리 내용 |
|------|-----------|
| **시스템 경계** (API 핸들러, UI 이벤트) | 사용자에게 보여줄 에러 메시지 변환 |
| **외부 서비스 호출** (DB, API, 파일) | 재시도, 폴백, 타임아웃 |
| **글로벌 핸들러** | 예상치 못한 에러 로깅 |

## 어디서 잡지 말 것인가

- 내부 함수 간 호출 — 에러를 그대로 전파
- 무의미한 catch-rethrow — `catch(e) { throw e }` 금지
- 에러 삼킴 — `catch(e) {}` 절대 금지

## 패턴

### 커스텀 에러 클래스
```
AppError (base)
├── ValidationError (400)
├── AuthenticationError (401)
├── ForbiddenError (403)
├── NotFoundError (404)
└── InternalError (500)
```

### 에러 응답 원칙
- 사용자에게: 이해 가능한 메시지
- 로그에: 디버깅에 필요한 전체 정보
- 클라이언트에: 내부 구현 절대 노출 금지

### 비동기 에러
- Promise는 반드시 catch 또는 try-await-catch
- 이벤트 기반은 error 이벤트 리스너 필수
- unhandledRejection 글로벌 핸들러 설정
