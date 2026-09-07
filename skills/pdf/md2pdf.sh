#!/bin/bash
# [ainative-core] Render a markdown file to a styled PDF next to it.
# Pipeline: mermaid syntax check -> pandoc (markdown -> standalone HTML with embedded CSS)
#           -> Chrome/Edge headless (HTML -> PDF).
# Usage: bash md2pdf.sh <file.md> [output.pdf]
# Exit codes: 1 = missing tool or file, 2 = mermaid syntax errors (fix the diagram and rerun)
set -e

SRC="$1"; OUT="${2:-}"
[ -n "$SRC" ] || { echo "Usage: bash md2pdf.sh <file.md> [output.pdf]"; exit 1; }
[ -f "$SRC" ] || { echo "Not found: $SRC"; exit 1; }
command -v pandoc >/dev/null || { echo "pandoc is required: https://pandoc.org/installing.html"; exit 1; }

SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$(cd "$(dirname "$SRC")" && pwd)"
STEM="$(basename "${SRC%.*}")"
[ -n "$OUT" ] || OUT="$SRC_DIR/$STEM.pdf"
to_url() { if command -v cygpath >/dev/null 2>&1; then echo "file:///$(cygpath -m "$1")"; else echo "file://$1"; fi; }

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

# --- mermaid: cache the script locally (offline rendering) and validate every block first
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ainative-core"
MERMAID_JS="$CACHE_DIR/mermaid.min.js"
if [ ! -s "$MERMAID_JS" ]; then
  mkdir -p "$CACHE_DIR"
  curl -fsSL -o "$MERMAID_JS" https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js \
    || { rm -f "$MERMAID_JS"; echo "Could not download Mermaid (offline?). Diagrams will be left as code."; }
fi
if [ -s "$MERMAID_JS" ] && ! ERRORS=$(bash "$SKILL_DIR/mermaid-check.sh" "$SRC" "$BROWSER" "$MERMAID_JS"); then
  echo "Mermaid syntax errors in $SRC:"
  printf '%s\n' "$ERRORS"
  echo "Fix the diagram(s) and run again. Common cause: ( ) { } [ ] \" or : inside a label; wrap the label in double quotes."
  exit 2
fi

# --- metadata defaults: title from YAML, else the single leading H1, else the file name
META=()
SRC_FOR_PANDOC="$SRC"; BODY=""
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

# --- markdown -> html --------------------------------------------------------------
HTML=$(mktemp --suffix=.html)
MERMAID_HTML=$(mktemp --suffix=.html)
if [ -s "$MERMAID_JS" ]; then
  sed "s#https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js#$(to_url "$MERMAID_JS")#" "$SKILL_DIR/mermaid.html" > "$MERMAID_HTML"
fi
pandoc "$SRC_FOR_PANDOC" -f gfm+yaml_metadata_block -t html5 --standalone \
  --css "$SKILL_DIR/style.css" --embed-resources \
  --include-after-body "$MERMAID_HTML" \
  "${META[@]}" -o "$HTML"

# --- html -> pdf -------------------------------------------------------------------
if command -v cygpath >/dev/null 2>&1; then OUT_ARG="$(cygpath -w "$OUT")"; else OUT_ARG="$OUT"; fi
"$BROWSER" --headless=new --disable-gpu --no-pdf-header-footer \
  --virtual-time-budget=10000 --print-to-pdf="$OUT_ARG" "$(to_url "$HTML")" >/dev/null 2>&1
rm -f "$HTML" "$MERMAID_HTML" "$BODY"

[ -s "$OUT" ] || { echo "PDF was not produced"; exit 1; }
echo "$OUT"
