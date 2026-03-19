#!/bin/bash
# ainative-core installer
# Copies rules, commands, agents, and skills to ~/.claude/

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

echo "Done. Installed to $TARGET_DIR"
