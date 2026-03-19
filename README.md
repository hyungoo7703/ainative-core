# ainative-core

Personal Claude Code harness — universal rules, commands, skills, and agents for any project.

## Structure

```
ainative-core/
├── rules/       ← Always-on rules (coding style, security, git conventions)
├── commands/    ← Slash commands (plan, init, spec, etc.)
├── skills/      ← Auto-activated workflows (review, debug, verify, etc.)
├── agents/      ← Specialized sub-agents (reviewer, planner)
└── install.sh   ← Install to ~/.claude/
```

## Install

```bash
bash install.sh
```

## What's Included

### Rules (4)
`language` · `coding-style` · `git-convention` · `security`

### Commands (12)
`/research` · `/spec` · `/init` · `/plan` · `/tdd` · `/check-env` · `/security` · `/summarize` · `/docs` · `/how-to-run` · `/continue` · `/usage`

### Skills (11) — auto-activated
`review` · `debug` · `verify` · `refactor` · `api-design` · `error-handling` · `performance` · `accessibility` · `pr-description` · `code-review-response` · `explain`

### Agents (2)
`reviewer` · `planner`

## Principles

1. Observe first — record repeated patterns from real usage
2. Automate only what repeats 3+ times
3. Build order: rules → commands → skills → agents → hooks
4. Delete what you don't use
