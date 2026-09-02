---
name: pr-description
description: Pull request writing guide. Use when creating a PR or writing its description.
---

Write PRs so the reviewer understands them quickly.

## Title
- Under 70 characters
- Conventional Commits: `feat: ...` / `fix: ...`
- Lead with "why", not "what"

## Body template

```markdown
## Summary
(1 to 3 lines: what this PR does and why)

## Changes
- (main change 1)
- (main change 2)

## Screenshots
(before/after for UI changes)

## Testing
- [ ] Unit tests added or updated
- [ ] Manual testing done
- [ ] Existing tests pass

## Checklist
- [ ] Self-reviewed
- [ ] No leftover debug output (console.log, print, ...)
- [ ] Docs updated (if applicable)
```

## Principles
- One purpose per PR
- Split large PRs to reduce reviewer load
- Use draft PRs for early feedback
