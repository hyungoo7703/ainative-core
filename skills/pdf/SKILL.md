---
name: pdf
description: Render a markdown file to a styled, submission-ready PDF placed next to it.
disable-model-invocation: true
argument-hint: "<file.md> [output.pdf]"
---

Render `$ARGUMENTS` (a markdown file) to a PDF in the same folder, same name, `.pdf` extension.

Run:

```
bash ~/.claude/skills/pdf/md2pdf.sh <file.md> [output.pdf]
```

Then reply with the PDF path only.

- Exit 2 means Mermaid syntax errors; the output lists the markdown line of each broken block and the parser message. Fix the diagram in the markdown (usually: wrap a label containing `( ) { } [ ] " :` in double quotes, e.g. `A -->|"POST /x/{id}"| B`), rerun, and mention what you changed.
- Any other error (pandoc or a browser missing, file not found): show the message and stop.

## What the renderer does

- pandoc turns the markdown (GitHub flavor plus YAML front matter) into HTML with the bundled `style.css`, then Chrome or Edge in headless mode prints it to A4.
- Title block: `title`, `subtitle`, `author`, `date` from YAML front matter. Without front matter, a single leading `# Heading` becomes the title; otherwise the file name is used. `date` defaults to today.
- Mermaid code blocks are validated with the real parser before rendering, then drawn as diagrams. The Mermaid script is downloaded once to `~/.cache/ainative-core/` and used offline afterwards.
- Tables, code blocks, and headings avoid page breaks inside them.

## Before rendering

If the file has no YAML front matter and the user is preparing a document to submit, offer to add one (`title`, `author`, `date`) so the cover looks right. Do not change the body.

## Requirements

`pandoc` on PATH and Chrome, Chromium, or Edge installed. Override the browser with `CLAUDE_PDF_BROWSER=<path>`.
