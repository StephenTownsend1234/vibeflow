#!/bin/bash
# vibeflow SessionEnd/PreCompact hook — deterministic breadcrumb for unwrapped work.
# Writes .claude/.session-snapshot.md when a session ends (or compacts) with work
# not yet reconciled by a wrap. The SessionStart hook injects its head next session;
# /wrap reads it during grounding and deletes it once reconciled. Fail-silent.
set +e
cd "$CLAUDE_PROJECT_DIR" 2>/dev/null || exit 0
[ -d .claude ] || exit 0

last_wrap=$(git log --grep='docs(wrap):' --format='%H' -1 2>/dev/null)
range=""
[ -n "$last_wrap" ] && range="$last_wrap..HEAD"
stat=$(git diff --stat $range 2>/dev/null | tail -1)
unc=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
commits=$(git log --oneline $range 2>/dev/null | head -3)

# Clean tree and nothing since the last wrap → nothing unwrapped; clear any stale snapshot.
if [ "${unc:-0}" = "0" ] && [ -z "$commits" ]; then
  rm -f .claude/.session-snapshot.md
  exit 0
fi

{
  echo "Unwrapped work as of $(date '+%F %H:%M') (auto-snapshot; /wrap reconciles + deletes this)"
  echo "Since last wrap: ${stat:-no committed changes}; uncommitted files: $unc"
  [ -n "$commits" ] && echo "$commits"
} > .claude/.session-snapshot.md
exit 0
