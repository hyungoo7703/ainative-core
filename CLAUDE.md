# ainative-core

Personal Claude Code harness, installed into `~/.claude/` by `install.sh`. Public repo.

## Conventions

- Everything here is in English. The response language is substituted into `rules/language.md` at install time, never committed
- A skill with `disable-model-invocation: true` is a command the user runs as `/name`. A skill without it is an auto skill: its `description` is the trigger, so write it as "use when ..."
- Skill folder name and the `name` field in `SKILL.md` must match; `install.sh` copies by folder
- `install.sh` removes what a previous install shipped and this version no longer does, using manifests in `~/.claude/.ainative-*`. When renaming or deleting a rule, agent, hook, or skill, that is all that is needed; do not add special cases unless the file predates the manifests
- `rules/languages/*.md` are copied flat into `~/.claude/rules/`, so their file names must not collide with the top-level rules
- Hook scripts live in `hooks/` and are referenced from `hooks.json` with the `[ainative-core]` marker, which is how reinstalls find and replace them in `settings.json`

## Privacy

No file in this repo may contain project paths, quoted session lines, internal URLs, or credentials. Usage evidence goes in as counts only.

## Harness review

`/harness-review` proposes changes from usage snapshots and applies only what the user picks. Anything declined or deferred goes to `docs/deferred-decisions.md` with its evidence and revisit condition; the next review starts from that file. Applied items move to its applied section.

## Commits

Conventional Commits, one change per commit, no push without the user asking. Local account settings for this checkout are in `CLAUDE.local.md` (gitignored).
