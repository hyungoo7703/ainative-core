---
name: review
description: Code review. Use after code changes, on git diff, or when preparing a PR.
---

Read the changed code with `git diff` and review against:

1. **Bugs**: logic errors, off-by-one, missing null/undefined handling
2. **Security**: input validation, secret exposure, injection
3. **Readability**: naming, unnecessary complexity, magic numbers
4. **Error handling**: appropriate handling at system boundaries

Report in this format:
- 🔴 **Must fix**: bugs or security issues
- 🟡 **Recommended**: worthwhile improvements
- 🟢 **Good**: well-written parts

If nothing needs changing, end with "LGTM".
