---
name: clip
description: Save an earlier answer from this conversation verbatim as a markdown file, so tables and code survive.
disable-model-invocation: true
argument-hint: "[which part or which answer; empty = the whole previous answer]"
---

Save an earlier answer from this conversation to a file, exactly as it was written.

Target folder: the `CLAUDE_CLIPS` environment variable, or `~/.claude/clips` if unset. Create it if missing.

## Steps

1. Pick the content. `$ARGUMENTS` names the part or the answer ("the table", "the test cases from two answers ago"). If empty, take the whole previous answer.
2. Write it verbatim. Keep the original markdown source: tables, code blocks, lists, headings. Do not summarize, reformat, or translate.
3. File name: `YYYY-MM-DD-<short-slug>.md`, slug of two to four words from the content, in the response language. If the name exists, append `-2`, `-3`.
4. File layout:

```
# <one-line title>
<date> · <current project folder name>

<content>
```

5. Reply with the saved path only, nothing else.
