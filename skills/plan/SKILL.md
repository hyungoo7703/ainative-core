---
name: plan
description: Write an implementation plan for a task.
disable-model-invocation: true
---

Write an implementation plan for the given task.
If the task was already decided in the conversation, plan it without asking again.
**If the project has a spec document (CLAUDE.md, docs/spec.md), read it first.**

1. **Spec**: check the spec for this feature if one exists
2. **Goal**: one-line summary of what to achieve
3. **Current state**: relevant code and files
4. **Steps**: in order, one commit per step
5. **Risks**: things to watch, blast radius
6. **Self-review**: check the plan for security, performance, and scalability problems; revise before presenting
7. **Verification**: how to confirm completion against the spec

Save the agreed plan to CLAUDE.md or docs/plan.md, then start implementing.
