---
name: remember
description: Record something to revisit later in the cross-project inbox.
disable-model-invocation: true
argument-hint: "[what to remember | list | done <keyword>]"
---

Record `$ARGUMENTS` in the inbox.

Inbox path: the `CLAUDE_INBOX` environment variable, or `~/.claude/inbox.md` if unset. Create the file if missing.
Archive path: `archive.md` in the same folder as the inbox.

## Default (argument is the thing to remember)

Append one line to the inbox:

```
- [ ] {today} | due {date or -} | {current project folder name} | {what} | {why}
```

1. Convert relative deadlines ("next week", "in 3 days") to absolute YYYY-MM-DD dates. No deadline: `-`
2. "why" is one sentence on where this came from (observed data, logs, conversation context)
3. Show the appended line

## Subcommands

- No argument: list follow-up candidates that came up in this session and record only the ones the user confirms
- `list`: show all open items sorted by due date
- `done <keyword>`: mark matching items `[x]`, move them to archive.md, and remove them from the inbox. Confirm first if more than one matches

## Auto-archive

The SessionStart hook moves open items more than 30 days past their due date to archive.md, marked `auto-archived <date>`. Items without a due date are never auto-archived.
