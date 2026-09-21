# Git Convention

- Follow Conventional Commits
  - `feat:` new feature
  - `fix:` bug fix
  - `refactor:` refactoring
  - `docs:` documentation
  - `chore:` build, config, misc
  - `test:` tests
- Commit messages start lowercase, no trailing period
- One change per commit
- Branch names: `feat/xxx`, `fix/xxx`, `chore/xxx`

## PRs and merging

- The user merges PRs. Claude never merges on its own
- When parallel work produces several PRs:
  1. Claude merges them into one integration branch and resolves conflicts
  2. Claude opens a PR from the integration branch
  3. The user reviews and merges

## PR descriptions

- Title under 70 characters, Conventional Commits prefix, leads with why
- Body order: Summary (1 to 3 lines) → Changes → Testing → Screenshots for UI changes
- One purpose per PR; split a large one to reduce reviewer load
- Draft PRs for early feedback

## Responding to review feedback

- Classify each comment: must fix (bugs, security, logic), recommended (readability, naming, structure), needs discussion (design, trade-offs)
- Must-fix items first, one commit per piece of feedback so the reviewer can verify each
- Reply to every comment; when you disagree, explain with evidence and change only after agreement
- Summarize the changes when requesting re-review
