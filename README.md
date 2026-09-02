# ainative-core

Personal Claude Code harness — universal rules, commands, skills, and agents for any project.

## Structure

```
ainative-core/
├── rules/       ← Always-on rules (coding style, security, git conventions)
├── commands/    ← Slash commands (plan, init, spec, etc.)
├── skills/      ← Auto-activated workflows (review, debug, verify, etc.)
├── agents/      ← Specialized sub-agents (reviewer, planner)
├── hooks/       ← Hook scripts (referenced from hooks.json)
└── install.sh   ← Install to ~/.claude/
```

## Install

```bash
bash install.sh
```

## What's Included

### Rules (4)
`language` · `coding-style` · `git-convention` · `security`

### Commands (13)
`/research` · `/spec` · `/init` · `/plan` · `/tdd` · `/check-env` · `/security` · `/summarize` · `/docs` · `/how-to-run` · `/continue` · `/usage` · `/remember`

### Skills (11) — auto-activated
`review` · `debug` · `verify` · `refactor` · `api-design` · `error-handling` · `performance` · `accessibility` · `pr-description` · `code-review-response` · `explain`

### Agents (2)
`reviewer` · `planner`

### Hooks
- `SessionStart` — shows inbox items for the current project or due within 7 days
- `PostToolUse` (git commit) — reminds to run `/review`
- `Stop` — reminds to run `/verify`

## Remember (cross-project inbox)

`/remember <what>` appends one line to an inbox file; the SessionStart hook surfaces relevant lines when you open a project.
The inbox lives outside this repo. Point to it with `CLAUDE_INBOX` in `~/.claude/settings.json` (defaults to `~/.claude/inbox.md`):

```json
{ "env": { "CLAUDE_INBOX": "/path/to/inbox.md" } }
```

Line format: `- [ ] recorded | due YYYY-MM-DD or - | project | what | why`

## Principles

1. Observe first — record repeated patterns from real usage
2. Automate only what repeats 3+ times
3. Build order: rules → commands → skills → agents → hooks
4. Delete what you don't use
