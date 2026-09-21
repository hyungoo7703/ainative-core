---
title: Deferred Decisions
date: 2026-09-21
---

# Deferred Decisions

Items raised by `/harness-review` that were **not** applied, kept here with the evidence
that raised them so the next review starts from a decision, not from scratch.

Snapshot basis: 72 sessions, 6,615 user turns, 2026-08 through 2026-09. One snapshot
only, so no trend was available. A second reading of zero turns a candidate into a
decision.

## Applied on 2026-09-21, for context

- Merged `pr-description` and `code-review-response` into `rules/git-convention.md`
- Removed the `verify` skill, its three dangling references, and its README entry: 0 invocations,
  and its content (build, tests, evidence before claims) duplicates the verification guidance
  Claude Code applies by default, so unlike D1 a second snapshot could not change the answer
- Removed the Go and Rust language rules: 0 `.go` and 0 `.rs` files across 14 active projects
- Added manifest-based pruning for `rules/`, `agents/`, and `hooks/` in `install.sh`

## Deferred

### D1. Auto skills with 0 invocations in 6,615 user turns

`accessibility`, `api-design`, `performance`, `refactor`, `error-handling`

All five are model-invocable, with no `disable-model-invocation` in their frontmatter, so
zero means the model never chose them rather than that the counter missed them.
`error-handling` additionally duplicates a line already in `rules/coding-style.md`:
"Handle errors only at system boundaries".

Decision needed: delete, or accept them as a cheap safety net.
Revisit: if the next snapshot also reads 0, delete.

### D2. Manual skills with 0 typed invocations across 72 sessions

`research`, `tdd`, `summarize`, `why`, `check-env`

`research` overlaps the built-in deep-research skill. `why` overlaps `explain`, invoked
6 times. `summarize` is the closest remaining fit for drafting a PR body now that
`pr-description` is gone, so it carries a reason to keep that the others lack.

Decision needed: same as D1.

### D3. `setup`, evidence too weak to act on

0 invocations, but several single-session projects were created inside the snapshot
window, which is exactly when `setup` would apply. Not enough to call it dead.
Revisit: needs two snapshots.

### D4. `usage`, candidate for replacement by the README

0 invocations. Its job, showing what the harness provides, is a one-shot task the README
already covers.

Decision needed: delete and point users at the README, or keep.

### D5. A context-hygiene rule

`/compact` was typed 54 times across 72 sessions, 0.75 per session, against roughly 8.2 MB
of transcript per session. Tool mix: Bash 10,880, Read 4,017, Grep 2,390.

Proposal: a `rules/context-hygiene.md` covering partial file reads, summarizing large
command output instead of piping it whole, and delegating broad searches to a sub-agent.

Risk: there is no way to measure whether the rule lowers the `/compact` count. Adding an
unmeasurable rule is the habit this review exists to catch, so the proposal is held until
the cost shows up in a second snapshot.

### D6. A review-after-write rule

`/review` was typed 26 times while the `review` skill auto-fired 5 times, against 8,245
write operations: Edit 6,919 plus Write 1,326. The skill's "use after code changes"
description is not firing in practice, and the user compensates by hand.

Proposal: one line in `rules/coding-style.md` saying that after a run of file edits, offer
a `git diff` review before declaring the work done.

### D7. Shell preference

Bash 10,880 calls against PowerShell 1,706, a ratio of 6.4 to 1, on Windows. Recording the
preference in a rule would stop the choice being re-made each session. Low impact, listed
for completeness.

## Out of scope for this repo

### Default model

`/model` was typed 51 times, 0.71 per session, and a four-session sample showed four
models in rotation within a single window. The default model lives in `settings.json`, not
in `rules/`, so nothing in this repo can fix it. Grouped with the other `settings.json`
work.

## Known measurement limits

- The collector's `SkillCalls` and `TypedCommands` counters are not mutually exclusive:
  skills marked `disable-model-invocation: true` still appear under `SkillCalls`. The two
  numbers cannot be summed, and any total built from them is an upper bound.
- Rules are injected, never logged, so no rule can be measured by invocation count.
  Every rule decision recorded here rests on reference integrity and on whether matching
  code exists at all, not on usage counts.
- Skill names that collide with built-ins, namely `docs`, `review`, `plan`, `pdf`, and
  `research`, cannot be attributed to one side or the other from a snapshot alone.
