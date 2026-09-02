#!/bin/bash
# ainative-core installer
# Copies rules, skills, agents, and hook scripts to ~/.claude/ and merges hooks.json into settings.json
#
# Usage: bash install.sh [--lang <language>]
#   --lang   Language Claude responds in (e.g. Korean, ko, English, ja). Default: English.
#            The choice is saved to ~/.claude/.ainative-lang and reused on later installs.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.claude"
LANG_FILE="$TARGET_DIR/.ainative-lang"

# --- response language ---------------------------------------------------------
RESPONSE_LANGUAGE=""
while [ $# -gt 0 ]; do
  case "$1" in
    --lang) RESPONSE_LANGUAGE="$2"; shift 2 ;;
    --lang=*) RESPONSE_LANGUAGE="${1#--lang=}"; shift ;;
    *) echo "Unknown option: $1"; echo "Usage: bash install.sh [--lang <language>]"; exit 1 ;;
  esac
done
if [ -z "$RESPONSE_LANGUAGE" ] && [ -f "$LANG_FILE" ]; then
  RESPONSE_LANGUAGE="$(cat "$LANG_FILE")"
fi
RESPONSE_LANGUAGE="${RESPONSE_LANGUAGE:-English}"
case "$RESPONSE_LANGUAGE" in
  ko|kr) RESPONSE_LANGUAGE="Korean" ;;
  en) RESPONSE_LANGUAGE="English" ;;
  ja|jp) RESPONSE_LANGUAGE="Japanese" ;;
  zh|cn) RESPONSE_LANGUAGE="Chinese" ;;
esac
mkdir -p "$TARGET_DIR"
printf '%s' "$RESPONSE_LANGUAGE" > "$LANG_FILE"
echo "Installing ainative-core to $TARGET_DIR (response language: $RESPONSE_LANGUAGE) ..."

# --- rules, agents, hook scripts (flat copy) -----------------------------------
for dir in rules agents hooks; do
  mkdir -p "$TARGET_DIR/$dir"
  find "$SCRIPT_DIR/$dir" -type f ! -name '.gitkeep' -exec cp {} "$TARGET_DIR/$dir/" \;
done
# rules/language.md is a template; fill in the chosen language
sed "s/{{RESPONSE_LANGUAGE}}/$RESPONSE_LANGUAGE/g" "$SCRIPT_DIR/rules/language.md" > "$TARGET_DIR/rules/language.md"

# --- skills (keep skills/<name>/ layout) ----------------------------------------
for skill_dir in "$SCRIPT_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  mkdir -p "$TARGET_DIR/skills/$skill_name"
  cp "$skill_dir"* "$TARGET_DIR/skills/$skill_name/"
  # Commands were merged into skills; drop the legacy command file so /name is not registered twice
  rm -f "$TARGET_DIR/commands/$skill_name.md"
done

# --- hooks.json -> settings.json ------------------------------------------------
NODE_SETTINGS=$(cygpath -w "$TARGET_DIR/settings.json" 2>/dev/null || echo "$TARGET_DIR/settings.json")
NODE_HOOKS=$(cygpath -w "$SCRIPT_DIR/hooks.json" 2>/dev/null || echo "$SCRIPT_DIR/hooks.json")
node -e "
  const fs = require('fs');
  const [settingsPath, hooksPath] = process.argv.slice(1);
  const settings = fs.existsSync(settingsPath) ? JSON.parse(fs.readFileSync(settingsPath, 'utf8')) : {};
  const incoming = JSON.parse(fs.readFileSync(hooksPath, 'utf8')).hooks || {};
  settings.hooks = settings.hooks || {};
  const isOurs = h => (h.hooks || []).some(x => (x.command || '').includes('[ainative-core]'));
  // Remove every previously installed ainative-core hook, including events no longer in hooks.json
  for (const event of Object.keys(settings.hooks)) {
    settings.hooks[event] = settings.hooks[event].filter(h => !isOurs(h));
    if (settings.hooks[event].length === 0) delete settings.hooks[event];
  }
  for (const [event, list] of Object.entries(incoming)) {
    settings.hooks[event] = [...(settings.hooks[event] || []), ...list];
  }
  fs.writeFileSync(settingsPath, JSON.stringify(settings, null, 2));
  console.log('Hooks merged into settings.json');
" "$NODE_SETTINGS" "$NODE_HOOKS"

echo "Done. Installed to $TARGET_DIR"
