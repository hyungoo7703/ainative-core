#!/bin/bash
# [ainative-core] PostToolUse (Bash): remind to run /review after a git commit
# Hook input arrives as JSON on stdin; only the command that was run is inspected, not its output.
node -e "
  let s = '';
  process.stdin.on('data', d => s += d).on('end', () => {
    let cmd = '';
    try { cmd = JSON.parse(s).tool_input.command || ''; } catch (e) {}
    if (cmd.includes('git commit')) console.log('[ainative-core] Commit done. Run /review to review the changes.');
  });
"
exit 0
