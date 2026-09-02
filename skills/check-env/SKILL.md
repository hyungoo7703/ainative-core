---
name: check-env
description: Find missing environment config and hardcoded values.
disable-model-invocation: true
---

Scan the project for environment-related problems.

## Checks

### 1. Hardcoded values
- URLs (localhost, specific IPs or domains)
- Port numbers
- API keys, tokens, passwords
- Absolute file paths
- Personal data such as emails or phone numbers

### 2. Missing environment branching
- Settings that should differ between dev, staging, and production but do not
- Values that belong in environment variables but sit in code
- Variables in .env.example that the code never reads, or the reverse

### 3. Leftover temporary code
- TODO, FIXME, HACK, XXX comments
- Debug output: console.log, print, debugger
- Commented-out code blocks
- Temporary test data

### 4. Config file consistency
- .env.example vs the actual .env
- Per-environment config files (dev/staging/prod) missing entries
- Docker and deployment config env vars in sync

## Output

- 🔴 **Fix now**: security risk or would break production
- 🟡 **Confirm**: needs a decision on whether it is intentional
- 🟢 **OK**: environment config done well

Include file path and line number for every item.
