---
name: how-to-run
description: Explain how to run the current project.
disable-model-invocation: true
---

Analyze the file structure and explain how to run the project.

## Detecting the project type

- `manifest.json` with `browser_action` or `action` → **Chrome extension**
- `package.json` depending on `@modelcontextprotocol/sdk` (or `mcp` in Python) → **MCP server**
- `package.json` with a `bin` field → **CLI tool**
- `package.json` with `scripts.dev` → **Web app** (Next.js, Vite, ...)
- `Cargo.toml` → **Rust project**
- `go.mod` → **Go project**
- `pyproject.toml` or `requirements.txt` → **Python project**
- `Dockerfile` → **Docker container**

## Output

```
## Project type
(result)

## How to run
(step by step)

## Common commands
(if any)

## Notes
(if any)
```

Mention prerequisites (Node.js, Python, ...) when needed.
