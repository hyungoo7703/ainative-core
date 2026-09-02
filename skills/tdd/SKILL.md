---
name: tdd
description: Test-driven development (Red-Green-Refactor).
disable-model-invocation: true
---

Work in the TDD cycle. Always write the test first.

## Cycle

1. **RED**: write a failing test
2. **GREEN**: write the minimum code that passes
3. **REFACTOR**: improve the code while keeping tests green

## Rules

- No code without a test
- Tests verify behavior, not implementation details
- Add one test at a time
- Fix the code, never the test, to make it pass

## Required cases

- Happy path
- Edge cases (null, empty, boundaries)
- Error conditions
- Mock external dependencies
