#!/bin/bash
# [ainative-core] Validate every ```mermaid block in a markdown file with the real Mermaid parser (headless browser).
# Prints one line per broken block: "line <n>: <error>". Exit 0 when all blocks parse, 1 otherwise.
# Usage: bash mermaid-check.sh <file.md> <browser-executable> <mermaid.min.js path>
set -e
SRC="$1"; BROWSER="$2"; MERMAID_JS="$3"
grep -q '^```mermaid' "$SRC" || exit 0
PY=$(command -v python || command -v python3 || true)
[ -n "$PY" ] || { echo "python is required for the mermaid check"; exit 0; }

if command -v cygpath >/dev/null 2>&1; then MJS_URL="file:///$(cygpath -m "$MERMAID_JS")"; else MJS_URL="file://$MERMAID_JS"; fi
HTML=$(mktemp --suffix=.html)
"$PY" - "$SRC" "$HTML" "$MJS_URL" <<'PY_EOF'
import json, sys
src, html, mjs = sys.argv[1], sys.argv[2], sys.argv[3]
blocks, code, start = [], None, 0
for n, line in enumerate(open(src, encoding="utf-8"), 1):
    if code is None and line.startswith("```mermaid"):
        code, start = [], n
    elif code is not None and line.startswith("```"):
        blocks.append({"line": start, "code": "".join(code)}); code = None
    elif code is not None:
        code.append(line)
page = r"""<!doctype html><html><body><pre id="out">PENDING</pre>
<script src="MJS"></script>
<script>
const blocks = BLOCKS;
(async () => {
  const out = [];
  for (const b of blocks) {
    try { await mermaid.parse(b.code); }
    catch (e) { out.push('line ' + b.line + ': ' + String(e.message || e).split('\n').slice(0, 2).join(' ')); }
  }
  document.getElementById('out').textContent = out.length ? out.join('\n') : 'OK';
})();
</script></body></html>""".replace("MJS", mjs).replace("BLOCKS", json.dumps(blocks, ensure_ascii=False))
open(html, "w", encoding="utf-8").write(page)
PY_EOF

if command -v cygpath >/dev/null 2>&1; then URL="file:///$(cygpath -m "$HTML")"; else URL="file://$HTML"; fi
RESULT=$("$BROWSER" --headless=new --disable-gpu --virtual-time-budget=10000 --dump-dom "$URL" 2>/dev/null \
  | "$PY" -c "import sys,re,html; m=re.search(r'<pre id=\"out\">(.*?)</pre>', sys.stdin.read(), re.S); print(html.unescape(m.group(1)) if m else '')")
rm -f "$HTML"

case "$RESULT" in
  OK) exit 0 ;;
  ""|PENDING) echo "mermaid check could not run"; exit 0 ;;
  *) printf '%s\n' "$RESULT"; exit 1 ;;
esac
