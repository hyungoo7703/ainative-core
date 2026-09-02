#!/bin/bash
# [ainative-core] SessionStart: surface inbox items for this project or due within 7 days
INBOX="${CLAUDE_INBOX:-$HOME/.claude/inbox.md}"
[ -f "$INBOX" ] || exit 0

PROJECT=$(basename "$PWD")
TODAY=$(date +%Y-%m-%d)
LIMIT=$(date -d "+7 days" +%Y-%m-%d 2>/dev/null || date -v+7d +%Y-%m-%d)

HITS=$(grep '^- \[ \]' "$INBOX" | while IFS= read -r line; do
  due=$(printf '%s' "$line" | awk -F' [|] ' '{print $2}' | sed 's/^due //')
  proj=$(printf '%s' "$line" | awk -F' [|] ' '{print $3}')
  if [ "$proj" = "$PROJECT" ]; then
    printf '%s\n' "$line"
  elif [ "$due" != "-" ] && [ -n "$due" ] && [ "$due" \< "$LIMIT" -o "$due" = "$LIMIT" ]; then
    printf '%s\n' "$line"
  fi
done)

[ -n "$HITS" ] && printf '[ainative-core] Inbox items to remember (as of %s, project: %s)\n%s\nMention these to the user. When handled, run /remember done <keyword>.\n' "$TODAY" "$PROJECT" "$HITS"
exit 0
