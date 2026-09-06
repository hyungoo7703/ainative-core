#!/bin/bash
# [ainative-core] Render a markdown file to a styled PDF next to it.
# Pipeline: pandoc (markdown -> standalone HTML with embedded CSS) -> Chrome/Edge headless (HTML -> PDF).
# Usage: bash md2pdf.sh <file.md> [output.pdf]
set -e

SRC="$1"; OUT="${2:-}"
[ -n "$SRC" ] || { echo "Usage: bash md2pdf.sh <file.md> [output.pdf]"; exit 1; }
[ -f "$SRC" ] || { echo "Not found: $SRC"; exit 1; }
command -v pandoc >/dev/null || { echo "pandoc is required: https://pandoc.org/installing.html"; exit 1; }

SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$(cd "$(dirname "$SRC")" && pwd)"
STEM="$(basename "${SRC%.*}")"
[ -n "$OUT" ] || OUT="$SRC_DIR/$STEM.pdf"

# --- find a headless-capable browser ---------------------------------------------
BROWSER="${CLAUDE_PDF_BROWSER:-}"
if [ -z "$BROWSER" ]; then
  for c in google-chrome chromium chromium-browser msedge; do
    command -v "$c" >/dev/null 2>&1 && { BROWSER="$c"; break; }
  done
fi
if [ -z "$BROWSER" ]; then
  for p in \
    "/c/Program Files/Google/Chrome/Application/chrome.exe" \
    "/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" \
    "/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" \
    "/c/Program Files/Microsoft/Edge/Application/msedge.exe" \
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
    "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"; do
    [ -x "$p" ] && { BROWSER="$p"; break; }
  done
fi
[ -n "$BROWSER" ] || { echo "No Chrome/Chromium/Edge found. Set CLAUDE_PDF_BROWSER to the browser executable."; exit 1; }

# --- metadata defaults: title from YAML, else the single leading H1, else the file name
META=()
if ! grep -qE '^title:' "$SRC"; then
  H1_COUNT=$(grep -cE '^# ' "$SRC" || true)
  FIRST=$(grep -m1 -vE '^\s*$' "$SRC" || true)
  if [ "$H1_COUNT" = "1" ] && printf '%s' "$FIRST" | grep -qE '^# '; then
    META+=(-M "title=${FIRST#\# }")
    BODY=$(mktemp --suffix=.md); tail -n +2 "$SRC" > "$BODY"; SRC_FOR_PANDOC="$BODY"
  else
    META+=(-M "title=$STEM")
  fi
fi
grep -qE '^date:' "$SRC" || META+=(-M "date=$(date +%Y-%m-%d)")
SRC_FOR_PANDOC="${SRC_FOR_PANDOC:-$SRC}"

# --- markdown -> html --------------------------------------------------------------
HTML=$(mktemp --suffix=.html)
pandoc "$SRC_FOR_PANDOC" -f gfm+yaml_metadata_block -t html5 --standalone \
  --css "$SKILL_DIR/style.css" --embed-resources \
  --include-after-body "$SKILL_DIR/mermaid.html" \
  "${META[@]}" -o "$HTML"

# --- html -> pdf -------------------------------------------------------------------
if command -v cygpath >/dev/null 2>&1; then
  URL="file:///$(cygpath -m "$HTML")"; OUT_ARG="$(cygpath -w "$OUT")"
else
  URL="file://$HTML"; OUT_ARG="$OUT"
fi
"$BROWSER" --headless=new --disable-gpu --no-pdf-header-footer \
  --virtual-time-budget=10000 --print-to-pdf="$OUT_ARG" "$URL" >/dev/null 2>&1
rm -f "$HTML" "${BODY:-}"

[ -s "$OUT" ] || { echo "PDF was not produced"; exit 1; }
echo "$OUT"
