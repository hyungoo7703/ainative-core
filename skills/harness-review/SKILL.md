---
name: harness-review
description: Review how this harness (rules, skills, hooks) is actually used, from usage snapshots, and propose what to prune or promote.
disable-model-invocation: true
---

Review this harness against evidence of real use and propose changes. Run this from the ainative-core checkout so proposals can be applied in place.

## Inputs

1. **Snapshots**: JSON files produced by an external collector, one per run, named by timestamp. Find the folder in this order and stop at the first that exists:
   - a directory passed with `--add-dir` whose name is `snapshots`
   - `$CLAUDE_HARNESS_SNAPSHOTS`
   - `~/.claude/harness-snapshots`
   If none exists, say so and stop. Never guess paths.
2. **The harness itself**: `rules/`, `skills/*/SKILL.md`, `agents/`, `hooks/` in the current directory.
3. **Deferred decisions**: `docs/deferred-decisions.md`, if present. It holds what an earlier review raised but did not apply, with the evidence and the condition for revisiting. Start from those decisions; re-raise an item only when new evidence meets its revisit condition.

Read the newest snapshot and, if present, the one before it. A snapshot contains counts only, for example: sessions per project and month, `Skill` tool calls the model made on its own per skill, slash commands typed per command (a typed command and the `Skill` call that executes it count once, under typed; the snapshot's `Counting` field states the rule), hook firings, tool-name frequency, model switches, and the list of installed skills never invoked.

## What to produce

Work through these in order and report each with the numbers that justify it.

1. **Prune**: skills with zero invocations across all snapshots, and rules or hooks with no observable effect. For each, say whether to delete, merge into another skill, or keep because it is an auto skill that legitimately fires without the `Skill` tool.
2. **Promote**: behaviour the user repeats by hand that a rule or skill could absorb. Evidence is a slash command or tool pattern with high counts (for example many `/compact` calls suggest context guidance; many `/model` switches suggest a default-model rule).
3. **Trend**: what changed since the previous snapshot. Skip this section if there is only one snapshot.
4. **Gaps in the evidence**: rules cannot be measured directly because they are injected, not logged. If a proposal needs proof of user corrections, sample the session logs under `~/.claude/projects/` yourself: read only user turns, take a small sample, and quote at most one line per example. Do not scan every log.

## Rules

- Every proposal cites a number from a snapshot or a sampled line. No proposal without evidence.
- Propose; do not edit. After the report, offer to apply the changes and wait for the user to pick which ones.
- When applying, edit the files in this checkout and show the diff. Never commit or push.
- Items the user declines or defers go into `docs/deferred-decisions.md` with the numbers that raised them and what would settle them. Items applied move to its applied section for context.
- Keep private data private: never write project paths or quoted log lines into any file in this repository.
