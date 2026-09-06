---
name: usage
description: Show what ainative-core provides and the recommended workflow.
disable-model-invocation: true
---

Show the user what ainative-core provides.

1. Build the lists from the filesystem. Never rely on a hardcoded list:
   - Skills: every `SKILL.md` under `~/.claude/skills/*/` and `.claude/skills/*/`. Read `name`, `description`, and `disable-model-invocation` from the frontmatter
   - Agents: every `~/.claude/agents/*.md`
   - Rules: every `~/.claude/rules/*.md`
2. Present tables:
   - **Commands** (skills with `disable-model-invocation: true`): the user runs them with `/name`
   - **Auto skills** (the rest): applied when the situation matches; `/name` also works
   - **Agents**
   - **Rules** (always on)
3. Then the recommended workflow:

```
/research  → compare references and libraries
/spec      → requirements and feature spec
/setup     → tech stack and initial setup
/plan      → implementation plan
start coding
  (auto) review   → on code changes
  (auto) debug    → on errors
  (auto) verify   → before declaring work done
/tdd       → test-driven development (when needed)
/check-env → environment config check
/security  → security audit
/docs      → generate documentation
/pdf       → render a markdown file to a styled PDF
/clip      → save an answer verbatim as a markdown note
/remember  → record follow-ups for later
```

> Use `/tdd` for core business logic (payments, auth, data processing).
