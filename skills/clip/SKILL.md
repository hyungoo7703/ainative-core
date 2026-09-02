---
name: clip
description: Save an earlier answer from this conversation verbatim as a markdown note, with Obsidian-friendly properties and links.
disable-model-invocation: true
argument-hint: "[which part or which answer; empty = the whole previous answer]"
---

Save an earlier answer from this conversation to a note, exactly as it was written.

Clips folder: the `CLAUDE_CLIPS` environment variable, or `~/.claude/clips` if unset. Create it if missing.
The parent folder of the clips folder is treated as the Obsidian vault root.

## Steps

1. Pick the content. `$ARGUMENTS` names the part or the answer ("the table", "the test cases from two answers ago"). If empty, take the whole previous answer.
2. Write it verbatim. Keep the original markdown source: tables, code blocks, lists, headings. Do not summarize, reformat, or translate.
3. File name: `YYYY-MM-DD-<short-slug>.md`, slug of two to four words from the content, in the response language. If the name exists, append `-2`, `-3`.
4. Note layout (`<project>` is the current project folder name):

```
---
date: YYYY-MM-DD
project: <project>
tags: [clip, <project>]
source: claude
---
# <one-line title>
[[projects/<project>]] · [[YYYY-MM-DD]]

<content>
```

5. Make sure `projects/<project>.md` exists in the vault root so backlinks and the graph work. If missing, create it with a single line: `# <project>`.
6. Reply with the saved path only, nothing else.
