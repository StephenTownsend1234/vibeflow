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

  # ARCHITECTURE Map section only (exact-match start, exit at next ## section)
  if [ -f .claude/ARCHITECTURE.md ]; then
    awk 'f&&/^## /{exit} /^## Map$/{f=1} f' .claude/ARCHITECTURE.md | head -40
  fi

  # Roadmap: goal (+ its one-line elaboration) and Now/Next one-liners; stop at Later/Details
  if [ -f .claude/ROADMAP.md ]; then
    echo "--- Roadmap (top) ---"
    awk '/^## (Later|Details)/{exit}
         /^## Goal/{print; if((getline l)>0 && l!="") print l; next}
         /^#|^[0-9]+\.|^- |^\*\*/{print}' .claude/ROADMAP.md | head -25
  fi

  # Sprint status: per-file checkbox counts + first unchecked step
  for f in .claude/sprints/*.md; do
    [ -f "$f" ] || continue
    total=$(grep -cE '^[[:space:]]*- \[[ xX]\]' "$f" 2>/dev/null)
    done=$(grep -cE '^[[:space:]]*- \[[xX]\]' "$f" 2>/dev/null)
    if [ "${total:-0}" -eq 0 ]; then
      echo "Sprint $(basename "$f"): no checkbox steps — open the file for status"
    else
      next=$(grep -m1 -E '^[[:space:]]*- \[ \]' "$f" 2>/dev/null | sed -E 's/^[[:space:]]*- \[ \] //' | cut -c1-90)
      echo "Sprint $(basename "$f"): $done/$total done. Next: ${next:-–}"
    fi
  done

  # Research briefs available
  ls .claude/research/*.md 2>/dev/null | while read -r b; do echo "Brief: $b"; done

  # Work since last wrap commit (sprint files may be stale — repo is truth)
  last_wrap=$(git log --grep='docs(wrap):' --format='%H' -1 2>/dev/null)
  if [ -n "$last_wrap" ]; then
    n=$(git diff --stat "$last_wrap"..HEAD 2>/dev/null | tail -1)
    unc=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    echo "Since last wrap commit: ${n:-nothing committed}; uncommitted files: $unc"
  fi

  echo "</vibeflow-orientation>"
)

# Hard cap: 120 lines AND 16KB, whichever bites first
echo "$OUT" | head -120 | head -c 16000
exit 0
