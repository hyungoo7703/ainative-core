---
name: verify
description: Verification before declaring work done. Use when a task is finished, a feature is implemented, or you are about to say it works.
---

Before calling work done, verify the items below.
"It should work" is not verification. Run it and look at the result.

## Steps

1. **Build**: does it build
2. **Tests**: do all tests pass (0 failures)
3. **Lint**: no linter errors
4. **Original problem**: for a bug fix, is the original symptom gone
5. **Spec**: if a spec document exists (CLAUDE.md, docs/spec.md), read it and check every agreed item
6. **Requirements**: is everything that was asked for implemented
7. **Side effects**: did anything else break

## Forbidden without evidence

- "It should work"
- "It probably works"
- "Looks fine"

**Evidence first, claims second.**
