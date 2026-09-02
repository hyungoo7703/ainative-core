---
name: refactor
description: Step-by-step refactoring approach. Use when restructuring code or asked to refactor.
---

Refactor in small, verified steps.

## Principles

1. **Start from green**: existing tests pass
2. **One change at a time**: do not mix rename, extract, and move
3. **Run tests after every step**: revert immediately if they break
4. **Do not change behavior**: refactoring changes structure only

## Steps

1. Check test coverage of the code you will change
2. Add tests first if coverage is lacking
3. Change in small units (extract, rename, move, in that order)
4. Run tests after each change
5. Run the full suite when done

## Common refactorings

- **Extract Function**: pull a meaningful unit out of a long function
- **Rename**: make intent explicit
- **Move**: relocate to the right module or file
- **Inline**: remove an unnecessary abstraction
- **Replace Conditional with Polymorphism**: turn complex branching into polymorphism
