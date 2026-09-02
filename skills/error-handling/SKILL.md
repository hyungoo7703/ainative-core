---
name: error-handling
description: Error handling patterns. Use when writing try/catch or any error handling code.
---

Handle errors in the right place, in the right way.

## Where to catch

| Location | What to do |
|----------|------------|
| **System boundary** (API handler, UI event) | Convert to a user-facing message |
| **External calls** (DB, API, file) | Retry, fallback, timeout |
| **Global handler** | Log unexpected errors |

## Where not to catch

- Between internal functions: let errors propagate
- Pointless catch-and-rethrow: never `catch(e) { throw e }`
- Swallowing: never `catch(e) {}`

## Patterns

### Custom error classes
```
AppError (base)
├── ValidationError (400)
├── AuthenticationError (401)
├── ForbiddenError (403)
├── NotFoundError (404)
└── InternalError (500)
```

### Error responses
- To the user: an understandable message
- To the log: everything needed to debug
- To the client: never internal details

### Async errors
- Every Promise gets a catch or try/await/catch
- Event-based code needs an error listener
- Register a global unhandledRejection handler
