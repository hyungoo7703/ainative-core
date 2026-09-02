---
name: spec
description: Analyze requirements and write a feature spec.
disable-model-invocation: true
---

Turn requirements into a concrete feature spec.

## Steps

### 1. Gather requirements
Use what was already said in the conversation; ask only about gaps.
- Who uses it? (user types)
- What are the core features?
- Must-have vs nice-to-have
- Constraints (technical, environmental, schedule)

### 2. Prioritize

| Priority | Meaning |
|----------|---------|
| **P0 (must)** | cannot ship without it |
| **P1 (important)** | recommended for the first release |
| **P2 (optional)** | later iterations |

### 3. Write the spec
For each feature:

```
## Feature name
- Description: one line
- User story: "As a ..., I want ..., so that ..."
- Input/output: what it takes and returns
- Error cases
- UI flow: (if applicable) screen transitions
```

### 4. Confirm scope
- Show the spec to the user
- Adjust what is missing or unnecessary
- Agree on the MVP scope

### 5. Save
- Save the agreed spec to **CLAUDE.md** or **docs/spec.md**
- Later `/plan` and `/verify` runs reference it

## Rules

- Only what the user said goes into the spec; never add features by guessing
- Write from the user perspective, not the implementation
- Clarify ambiguity with questions
- Always save the spec to a file
