---
name: continue
description: Pick up remaining work from a previous plan or session.
disable-model-invocation: true
---

Find what is left from a previous plan or in-progress work and continue.
Use context from the conversation; do not re-ask what is already known.

## Steps

1. **Check git state**
   - Run `git branch`, `git log --oneline -10`, `git status`
   - Check whether the current branch is already merged (compare with main)
   - If merged: switch to main, pull, and suggest a new branch
   - If main is behind the remote, pull first
   - Merged local branches may be deleted with `git branch -d`. Never delete remote branches; the user decides that

2. **Establish current state**
   - Read the spec and plan documents if present (CLAUDE.md, docs/spec.md, docs/plan.md)
   - Check git log, git diff, TODO lists, and conversation context
   - Separate done from remaining

3. **List remaining work**
   - Remaining items in priority order
   - Rough effort per item

4. **Recommend the next task**
   - Recommend one item and ask whether to start
   - Do not force a choice by dumping the whole list

5. **Resume**
   - Start as soon as confirmed
