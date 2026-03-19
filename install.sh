#!/bin/bash
# ainative-core installer
# Copies rules, commands, and agents to ~/.claude/

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.claude"

echo "Installing ainative-core to $TARGET_DIR ..."

# Create target directories
mkdir -p "$TARGET_DIR/rules"
mkdir -p "$TARGET_DIR/commands"
mkdir -p "$TARGET_DIR/agents"

# Copy files (excluding .gitkeep)
for dir in rules commands agents; do
  if [ -d "$SCRIPT_DIR/$dir" ]; then
    find "$SCRIPT_DIR/$dir" -type f ! -name '.gitkeep' -exec cp {} "$TARGET_DIR/$dir/" \;
  fi
done

echo "Done. Installed to $TARGET_DIR"
