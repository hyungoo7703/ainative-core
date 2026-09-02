---
name: why
description: Explain why a piece of code was written the way it is.
disable-model-invocation: true
---

Analyze why the selected code, file, or function is written the way it is.
If the target was already mentioned in the conversation, analyze it without asking again.

## Steps

1. **git blame / git log**: who wrote or changed it, when, in which commit
2. **Commit messages**: is the reason recorded
3. **Related code**: callers and dependencies
4. **Alternatives**: could it have been done differently, and why was this way chosen

## Output

```
## What this code does
(one line)

## Why it is written this way
(based on git history, commit messages, code context)

## Is there a problem
(point it out, or state that the current implementation is appropriate)

## Is there a better way
(propose if so, otherwise omit)
```

## Rules

- Explain from evidence (git history, code context), not guesses
- Never answer with "that is just how it is done"; give concrete reasons
- Keep answering follow-up questions until the user is satisfied
