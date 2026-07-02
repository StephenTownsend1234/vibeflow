#!/bin/bash
# vibeflow SessionStart hook — injects project orientation as additionalContext.
# Deterministic, fail-silent, hard-capped output. Installed per-project by /bootstrap.
set +e
cd "$CLAUDE_PROJECT_DIR" 2>/dev/null || exit 0
[ -d .claude ] || exit 0

OUT=$(
  echo "<vibeflow-orientation date=\"$(date +%F)\">"

  # Project identity (capped)
  [ -f .claude/PROJECT.md ] && head -30 .claude/PROJECT.md

  # ARCHITECTURE Map section only (capped)
  if [ -f .claude/ARCHITECTURE.md ]; then
    awk '/^## Map/{f=1} f&&/^## /&&!/^## Map/{exit} f' .claude/ARCHITECTURE.md | head -40
  fi

  # Roadmap: goal + Now/Next one-liners only (stop at Later or Details)
  if [ -f .claude/ROADMAP.md ]; then
    echo "--- Roadmap (top) ---"
    awk '/^## (Later|Details)/{exit} /^#|^[0-9]+\.|^- |^\*\*/{print}' .claude/ROADMAP.md | head -25
  fi

  # Sprint status: per-file checkbox counts + first unchecked step
  for f in .claude/sprints/*.md; do
    [ -f "$f" ] || continue
    total=$(grep -c '^\- \[' "$f" 2>/dev/null)
    done=$(grep -c '^\- \[x\]' "$f" 2>/dev/null)
    next=$(grep -m1 '^\- \[ \]' "$f" 2>/dev/null | cut -c7-90)
    echo "Sprint $(basename "$f"): $done/$total done. Next: ${next:-–}"
  done

  # Research briefs available
  ls .claude/research/*.md 2>/dev/null | while read -r b; do echo "Brief: $b"; done

  # Work since last wrap commit (sprint files may be stale — repo is truth)
  last_wrap=$(git log --grep='wrap' -i --format='%H' -1 2>/dev/null)
  if [ -n "$last_wrap" ]; then
    n=$(git diff --stat "$last_wrap"..HEAD 2>/dev/null | tail -1)
    unc=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    echo "Since last wrap commit: ${n:-nothing committed}; uncommitted files: $unc"
  fi

  echo "</vibeflow-orientation>"
)

# Hard cap: never inject more than 120 lines
echo "$OUT" | head -120
exit 0
