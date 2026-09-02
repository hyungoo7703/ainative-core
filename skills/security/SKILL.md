---
name: security
description: Security audit based on the OWASP Top 10.
disable-model-invocation: true
---

Scan the project for vulnerabilities using the OWASP Top 10.
Check every item and propose a concrete fix for each finding.

## Checks

### 1. Authentication and authorization (Broken Access Control, Authentication)
- Endpoints reachable without authentication
- Missing permission checks (regular users reaching admin features)
- Horizontal privilege escalation (accessing resources of other users)
- Session and token handling (expiry, refresh, storage)
- Password policy (minimum length, complexity, hashing algorithm)
- Brute-force defense (login attempt limits, lockout)
- JWT validation (signature, expiry, algorithm pinning)

### 2. Input validation (Injection)
- SQL injection, including ORM bypass; inspect every raw query
- XSS: stored, reflected, DOM-based
- Command injection (child_process, exec, system, ...)
- Path traversal (`../`)
- SSRF
- File upload validation (extension, MIME type, size, storage path)
- Deserialization (JSON.parse, pickle, eval, ...)
- ReDoS

### 3. Sensitive data exposure
- Hardcoded API keys, passwords, tokens, certificates
- Internal details in error responses (stack traces, DB structure, server version)
- Sensitive data in logs (passwords, card numbers, personal data)
- Sensitive files missing from .gitignore (.env, credentials, certificates)
- Over-fetching sent to the client (excess fields in API responses)
- Encryption: bcrypt/argon2 for passwords, AES-256 or stronger for data

### 4. Security misconfiguration
- Debug mode exposed in production
- Default accounts or passwords unchanged
- Unnecessary HTTP methods allowed
- Missing security headers (CSP, X-Frame-Options, X-Content-Type-Options, HSTS)
- Directory listing enabled
- Error pages leaking information

### 5. Vulnerable components
- Packages with known vulnerabilities (run npm audit, pip audit, snyk, ...)
- Packages with unnecessarily broad permissions
- Unmaintained packages
- License conflicts

### 6. Insecure communication
- HTTP instead of HTTPS
- CORS too open (`origin: *`)
- Cookies missing Secure, HttpOnly, SameSite
- API keys in URL parameters
- Unauthenticated WebSockets

### 7. Business logic
- No rate limiting (API abuse)
- Missing CSRF protection on state-changing requests
- Money or points logic trusting the client
- No duplicate-request protection (idempotency)

## Output

- 🔴 **Critical**: fix immediately, include a code example
- 🟡 **Warning**: exploitable under conditions, include the fix
- 🟢 **Good**: handled well

Include file path, line number, and OWASP category per item.
Finish with a summary table by severity.
