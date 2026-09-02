---
name: init
description: Choose a tech stack and set up a new project.
disable-model-invocation: true
---

Guide a new project from tech selection to initial setup.

## Steps

### 1. Understand the goal
Use decisions already made in the conversation; ask only about gaps.
- What is being built? (web app, API server, CLI, mobile app, extension, MCP server, ...)
- Who uses it? (just the user, a team, external users)
- Scale? (prototype, side project, production)

### 2. Recommend a stack
Compare options that fit the goal:

**Language and framework**
- Explain why each option is recommended
- Compare at least two

**Architecture**
- Full-stack framework vs separate frontend and backend
- Monolith vs microservices

**Database** (if needed)
- Relational vs NoSQL vs file-based
- ORM or not

**Deployment** (if needed)
- Local only vs cloud
- Platform (Vercel, Railway, Docker, ...)

### 3. Confirm
Summarize the recommended stack and get confirmation before continuing.

### 4. Set up
- Create the directory structure
- Initialize the package manager
- Create base config files (.gitignore, tsconfig, eslint, ...)
- Install dependencies
- Confirm the dev server starts
- Record the chosen stack in CLAUDE.md

### 5. Next steps
- Suggest `/plan` for the implementation plan
- Link the main reference docs

## Rules

- Respect choices the user has already made
- No excessive boilerplate
- When in doubt, default to the simplest option
