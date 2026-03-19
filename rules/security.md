# Security

- .env, credentials, API key 등 민감 정보는 절대 커밋하지 않는다
- .gitignore에 민감 파일 패턴이 포함되어 있는지 확인한다
- 사내 URL, 인프라 정보, 인증 정보는 public 저장소에 포함 금지
- 외부 입력은 항상 검증한다 (SQL injection, XSS, command injection 등)
