#!/bin/bash
# [ainative-core] SessionStart: surface inbox items for this project or due within 7 days.
# Housekeeping first: checked items ([x], e.g. ticked in Obsidian) and open items more than
# 30 days past due are moved to archive.md so the inbox stays short.
INBOX="${CLAUDE_INBOX:-$HOME/.claude/inbox.md}"
[ -f "$INBOX" ] || exit 0
ARCHIVE="$(dirname "$INBOX")/archive.md"

PROJECT=$(basename "$PWD")
TODAY=$(date +%Y-%m-%d)
LIMIT=$(date -d "+7 days" +%Y-%m-%d 2>/dev/null || date -v+7d +%Y-%m-%d)
CUTOFF=$(date -d "-30 days" +%Y-%m-%d 2>/dev/null || date -v-30d +%Y-%m-%d)

# Line format: - [ ] recorded | due YYYY-MM-DD or - | project | what | why
due_of()  { printf '%s' "$1" | awk -F' [|] ' '{print $2}' | sed 's/^due //'; }
proj_of() { printf '%s' "$1" | awk -F' [|] ' '{print $3}'; }
is_date() { case "$1" in [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) return 0 ;; *) return 1 ;; esac; }
archive_lines() { # $1 = lines to move, $2 = suffix appended to each line
  [ -f "$ARCHIVE" ] || printf '# Archive\n\n' > "$ARCHIVE"
  printf '%s\n' "$1" | sed "s/^- \[ \]/- [x]/; s/\$/ | $2/" >> "$ARCHIVE"
  grep -vxF -f <(printf '%s\n' "$1") "$INBOX" > "$INBOX.tmp" && mv "$INBOX.tmp" "$INBOX"
}
count() { printf '%s\n' "$1" | wc -l | tr -d ' '; }

# --- move checked items to the archive ------------------------------------------
DONE=$(grep '^- \[x\]' "$INBOX" || true)
if [ -n "$DONE" ]; then
  archive_lines "$DONE" "done $TODAY"
  printf '[ainative-core] Archived %s checked inbox item(s).\n' "$(count "$DONE")"
fi

# --- auto-archive items more than 30 days past due -------------------------------
EXPIRED=$(grep '^- \[ \]' "$INBOX" | while IFS= read -r line; do
  due=$(due_of "$line")
  if is_date "$due" && [ "$due" \< "$CUTOFF" ]; then printf '%s\n' "$line"; fi
done)
if [ -n "$EXPIRED" ]; then
  archive_lines "$EXPIRED" "auto-archived $TODAY (30 days past due)"
  printf '[ainative-core] Auto-archived %s inbox item(s) more than 30 days past due. See archive.md.\n' "$(count "$EXPIRED")"
fi

# --- surface items for this project or due within 7 days -------------------------
HITS=$(grep '^- \[ \]' "$INBOX" | while IFS= read -r line; do
  due=$(due_of "$line")
  if [ "$(proj_of "$line")" = "$PROJECT" ]; then
    printf '%s\n' "$line"
  elif is_date "$due" && { [ "$due" \< "$LIMIT" ] || [ "$due" = "$LIMIT" ]; }; then
    printf '%s\n' "$line"
  fi
done)

[ -n "$HITS" ] && printf '[ainative-core] Inbox items to remember (as of %s, project: %s)\n%s\nMention these to the user. When handled, run /remember done <keyword>, or tick the box in the inbox file.\n' "$TODAY" "$PROJECT" "$HITS"
exit 0
