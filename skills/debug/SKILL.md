---
name: debug
description: Systematic debugging. Use when an error occurs, a bug needs fixing, or something is not working.
---

Analyze bugs systematically. Never fix code by guessing.

## Four phases

### 1. Root cause investigation
- Read the error message and stack trace exactly
- Reproduce the problem
- Check recent changes
- Trace the data flow backwards

### 2. Pattern analysis
- Compare with working code that does the same thing
- Find the difference between working and broken code
- Identify dependencies and preconditions

### 3. Hypothesis testing
- State a clear hypothesis about the cause
- Test it with the smallest possible change
- Change one variable at a time
- If it fails, form a new hypothesis; do not stack fixes

### 4. Fix
- Write a test that reproduces the problem
- Apply a single fix that addresses the root cause
- Confirm the test passes and no other tests break

**After three failed fixes**: stop and reconsider whether the architecture itself is wrong.
