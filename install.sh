#!/bin/bash
# ainative-core installer
# Copies rules, commands, agents, and skills to ~/.claude/
# Merges hooks into ~/.claude/settings.json

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.claude"

echo "Installing ainative-core to $TARGET_DIR ..."

# Create target directories
mkdir -p "$TARGET_DIR/rules"
mkdir -p "$TARGET_DIR/commands"
mkdir -p "$TARGET_DIR/agents"

# Copy flat directories (rules, commands, agents)
for dir in rules commands agents; do
  if [ -d "$SCRIPT_DIR/$dir" ]; then
    find "$SCRIPT_DIR/$dir" -type f ! -name '.gitkeep' -exec cp {} "$TARGET_DIR/$dir/" \;
  fi
done

# Copy skills (preserve directory structure: skills/name/SKILL.md)
if [ -d "$SCRIPT_DIR/skills" ]; then
  for skill_dir in "$SCRIPT_DIR/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "$TARGET_DIR/skills/$skill_name"
    cp "$skill_dir"* "$TARGET_DIR/skills/$skill_name/" 2>/dev/null || true
  done
fi

# Merge hooks into settings.json using Node.js
if [ -f "$SCRIPT_DIR/hooks.json" ]; then
  echo "Merging hooks into settings.json ..."

  # Convert paths for Node.js on Windows
  NODE_SETTINGS=$(cygpath -w "$TARGET_DIR/settings.json" 2>/dev/null || echo "$TARGET_DIR/settings.json")
  NODE_HOOKS=$(cygpath -w "$SCRIPT_DIR/hooks.json" 2>/dev/null || echo "$SCRIPT_DIR/hooks.json")

  node -e "
    const fs = require('fs');
    const [settingsPath, hooksPath] = process.argv.slice(1);

    const settings = fs.existsSync(settingsPath)
      ? JSON.parse(fs.readFileSync(settingsPath, 'utf8'))
      : {};
    const hooks = JSON.parse(fs.readFileSync(hooksPath, 'utf8'));

    if (hooks.hooks) {
      if (!settings.hooks) settings.hooks = {};
      for (const [event, eventHooks] of Object.entries(hooks.hooks)) {
        if (!settings.hooks[event]) settings.hooks[event] = [];
        // Remove existing ainative-core hooks (identified by [ainative-core] in hook command)
        settings.hooks[event] = settings.hooks[event].filter(
          h => !h.hook || !h.hook.includes('[ainative-core]')
        );
        // Add new hooks
        settings.hooks[event].push(...eventHooks);
      }
    }

    fs.writeFileSync(settingsPath, JSON.stringify(settings, null, 2));
    console.log('Hooks merged successfully.');
  " "$NODE_SETTINGS" "$NODE_HOOKS"
fi

echo "Done. Installed to $TARGET_DIR"
