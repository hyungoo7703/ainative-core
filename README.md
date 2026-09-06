# ainative-core

Personal Claude Code harness: universal rules, skills, agents, and hooks for any project.

## Structure

```
ainative-core/
├── rules/       ← Always-on rules (language, coding style, git, security, per-language)
├── skills/      ← Slash commands and auto-applied workflows (one folder per skill)
├── agents/      ← Specialized sub-agents (reviewer, planner)
├── hooks/       ← Hook scripts referenced from hooks.json
├── hooks.json   ← Hook definitions merged into ~/.claude/settings.json
└── install.sh   ← Install to ~/.claude/
```

## Install

```bash
bash install.sh --lang Korean   # or ko, ja, English, ...
```

`--lang` sets the language Claude responds in. Everything in this repo is written in English; the language rule tells Claude to answer, and to render skill output templates, in your language. The choice is saved to `~/.claude/.ainative-lang`, so later installs can omit the flag.

## What is included

### Rules
`language` · `coding-style` · `git-convention` · `security` · `context-persistence` · per-language rules for TypeScript, Python, Go, Rust, C#

### Commands (skills you run with `/name`)
`/research` · `/spec` · `/setup` · `/plan` · `/tdd` · `/check-env` · `/security` · `/summarize` · `/docs` · `/how-to-run` · `/continue` · `/why` · `/remember` · `/clip` · `/pdf` · `/usage`

### Auto skills (Claude applies them when the situation matches)
`review` · `debug` · `verify` · `refactor` · `api-design` · `error-handling` · `performance` · `accessibility` · `pr-description` · `code-review-response` · `explain`

### Agents
`reviewer` · `planner`

### Hooks
- `SessionStart`: shows inbox items for the current project or due within 7 days; archives checked items (`[x]`, e.g. ticked in Obsidian) and items more than 30 days past due

## Remember (cross-project inbox)

`/remember <what>` appends one line to an inbox file; the SessionStart hook surfaces relevant lines when you open a project.
The inbox lives outside this repo. Point to it with `CLAUDE_INBOX` in `~/.claude/settings.json` (defaults to `~/.claude/inbox.md`):

```json
{ "env": { "CLAUDE_INBOX": "/path/to/inbox.md" } }
```

Line format: `- [ ] recorded | due YYYY-MM-DD or - | project | what | why`

## Clip (save an answer as-is)

`/clip` writes the previous answer (or the part you name) verbatim to a markdown note, so tables and code blocks are preserved. Set `CLAUDE_CLIPS` to the folder (defaults to `~/.claude/clips`). Notes carry `date`, `project`, and `tags` properties plus `[[projects/<name>]]` and `[[date]]` links, so an Obsidian vault rooted at the parent folder gets tags, backlinks, graph clustering, and Bases tables for free.

## PDF (markdown to a styled PDF)

`/pdf <file.md>` renders the file to `<file>.pdf` next to it: A4, Korean-safe fonts, styled tables and code, Mermaid diagrams, title block from YAML front matter. Needs `pandoc` and Chrome/Chromium/Edge (override with `CLAUDE_PDF_BROWSER`). Pairs with `/docs`, which writes front-matter-ready markdown.

## Principles

1. Observe first: record repeated patterns from real usage
2. Automate only what repeats 3+ times
3. Build order: rules → skills → agents → hooks
