# Context Persistence

Design decisions and specs must live in files as the single source of truth.

## Rules

- Specs agreed via `/spec` go to CLAUDE.md or docs/spec.md
- Implementation plans agreed via `/plan` go to CLAUDE.md or docs/plan.md
- The tech stack chosen in `/setup` is recorded in CLAUDE.md
- Update the relevant document immediately when a design changes
- At the start of a new session, read CLAUDE.md first

## Required references

- `/plan`: read the spec document
- `/continue`: read the spec and plan documents
- `/verify`: check against the spec document
- While coding: never implement in a direction that contradicts recorded decisions
