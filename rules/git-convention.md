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
