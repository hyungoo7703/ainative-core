# ainative-core

Personal Claude Code harness — universal rules, commands, and agents for any project.

## Structure

```
ainative-core/
├── rules/       ← Always-on rules (coding style, security, git conventions)
├── commands/    ← Slash commands (review, planning, etc.)
├── agents/      ← Specialized sub-agents (reviewer, planner, etc.)
└── install.sh   ← Install to ~/.claude/
```

## Install

```bash
./install.sh
```

## Principles

1. Observe first — record repeated patterns from real usage
2. Automate only what repeats 3+ times
3. Build order: rules → commands → agents → hooks
4. Delete what you don't use
