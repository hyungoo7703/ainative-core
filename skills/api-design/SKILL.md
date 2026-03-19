---
name: api-design
description: REST/GraphQL API 설계 가이드. API 엔드포인트 설계, 라우트 작성 시 자동 활성화.
---

API 설계 시 일관된 규칙을 따릅니다.

## REST API 규칙

### URL 설계
- 복수형 명사 사용: `/users`, `/orders`
- 계층 관계: `/users/{id}/orders`
- 동사 금지: `/getUsers` ❌ → `/users` ✅
- kebab-case: `/user-profiles`

### HTTP 메서드
| 메서드 | 용도 | 응답 코드 |
|--------|------|-----------|
| GET | 조회 | 200 |
| POST | 생성 | 201 |
| PUT | 전체 수정 | 200 |
| PATCH | 부분 수정 | 200 |
| DELETE | 삭제 | 204 |

### 응답 구조
```json
{
  "data": {},
  "meta": { "page": 1, "totalPages": 10 },
  "error": { "code": "NOT_FOUND", "message": "..." }
}
```

### 에러 응답
- 일관된 에러 형식 사용
- 적절한 HTTP 상태 코드 (400, 401, 403, 404, 500)
- 내부 구현 노출 금지

### 버전 관리
- URL 방식: `/api/v1/users`
- 하위 호환성 유지

## 공통
- 페이지네이션: cursor 기반 권장
- 필터링: 쿼리 파라미터 (`?status=active&sort=-createdAt`)
- Rate Limiting 헤더 포함
