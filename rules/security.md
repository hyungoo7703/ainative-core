# Security

- Never commit .env files, credentials, API keys, or other secrets
- Make sure .gitignore covers sensitive file patterns
- Internal URLs, infrastructure details, and credentials never go into public repositories
- Always validate external input (SQL injection, XSS, command injection, etc.)
