---
name: api-design
description: REST/GraphQL API design guide. Use when designing endpoints or writing routes.
---

Follow consistent rules when designing APIs.

## REST rules

### URLs
- Plural nouns: `/users`, `/orders`
- Hierarchy: `/users/{id}/orders`
- No verbs: `/getUsers` ❌ → `/users` ✅
- kebab-case: `/user-profiles`

### HTTP methods
| Method | Purpose | Status |
|--------|---------|--------|
| GET | read | 200 |
| POST | create | 201 |
| PUT | full update | 200 |
| PATCH | partial update | 200 |
| DELETE | delete | 204 |

### Response shape
```json
{
  "data": {},
  "meta": { "page": 1, "totalPages": 10 },
  "error": { "code": "NOT_FOUND", "message": "..." }
}
```

### Errors
- One consistent error format
- Appropriate status codes (400, 401, 403, 404, 500)
- Never expose internal implementation details

### Versioning
- URL-based: `/api/v1/users`
- Keep backward compatibility

## Common
- Pagination: prefer cursor-based
- Filtering: query parameters (`?status=active&sort=-createdAt`)
- Include rate-limit headers
