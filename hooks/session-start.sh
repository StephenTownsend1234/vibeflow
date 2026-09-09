#!/bin/bash
# vibeflow SessionStart hook — injects project orientation as additionalContext.
# Deterministic, fail-silent, hard-capped output. Installed per-project by /bootstrap.
#
# Order is load-bearing: recency first (sprints, other chats, commits, notes), stable
# orientation last (roadmap Now, Map) — so the byte cap can only ever cut the Map.
# The cap is 9KB because the harness spills hook output above ~10KB to a file and
# shows the model a 2KB preview.
set +e
[ -t 0 ] || IN=$(cat 2>/dev/null)
SID=$(printf '%s' "$IN" | sed -nE 's/.*"session_id":"([^"]+)".*/\1/p')
cd "$CLAUDE_PROJECT_DIR" 2>/dev/null || exit 0
[ -d .claude ] || exit 0

OUT=$(
  echo "<vibeflow-orientation date=\"$(date '+%F %H:%M')\">"
  [ -f .claude/PROJECT.md ] && head -1 .claude/PROJECT.md

  # Sprint status: per-file checkbox counts + first unchecked step
  echo "--- Sprints in flight ---"
  any=0
  for f in .claude/sprints/*.md; do
    [ -f "$f" ] || continue
    any=1
    total=$(grep -cE '^[[:space:]]*- \[[ xX]\]' "$f" 2>/dev/null)
    done=$(grep -cE '^[[:space:]]*- \[[xX]\]' "$f" 2>/dev/null)
    if [ "${total:-0}" -eq 0 ]; then
      echo "$(basename "$f" .md): no checkbox steps — open the file for status"
    else
      next=$(grep -m1 -E '^[[:space:]]*- \[ \]' "$f" 2>/dev/null | sed -E 's/^[[:space:]]*- \[ \] //' | cut -c1-90)
      echo "$(basename "$f" .md): $done/$total done. Next: ${next:-– (all steps checked — archive?)}"
    fi
  done
  [ "$any" -eq 0 ] && echo "none"

  # Other chats active now: transcripts touched in the last 20 min, minus this session.
  # Transcript format is internal to Claude Code — mtimes are the signal; the label is best-effort.
  slug=$(printf '%s' "$PWD" | sed 's#[^A-Za-z0-9]#-#g'); TD="$HOME/.claude/projects/$slug"
  if [ -d "$TD" ]; then
    live=$(find "$TD" -maxdepth 1 -name '*.jsonl' -mmin -20 2>/dev/null | grep -v "${SID:-__none__}")
    n=$(printf '%s' "$live" | grep -c .)
    if [ "$n" -gt 0 ]; then
      echo "--- Other chats active now: $n (their sprint files and uncommitted paths are theirs) ---"
      printf '%s\n' "$live" | while read -r f; do
        [ -n "$f" ] || continue
        t=$(stat -f '%Sm' -t '%H:%M' "$f" 2>/dev/null || stat -c '%y' "$f" 2>/dev/null | cut -c12-16)
        lbl=$(grep -m1 '"operation":"enqueue"' "$f" 2>/dev/null | sed -E 's/.*"content":"//; s/"[,}].*//' | cut -c1-70)
        echo "· last active $t · started with: ${lbl:-(unknown)}"
      done | head -4
    fi
  fi

  # Worktrees: parallel-work awareness (prints only when linked worktrees exist)
  wt=$(git worktree list 2>/dev/null)
  if [ -n "$wt" ] && [ "$(echo "$wt" | grep -c .)" -gt 1 ]; then
    echo "--- Worktrees ---"
    echo "$wt" | head -5
    git rev-parse --git-dir 2>/dev/null | grep -q "/worktrees/" && \
      echo "(this session is inside a linked worktree)"
  fi

  # Recent commits: the race-free record of what shipped, across every chat
  total=$(git log --since=36.hours --oneline 2>/dev/null | wc -l | tr -d ' ')
  if [ "${total:-0}" -gt 0 ]; then
    echo "--- Commits, last 36h ($total total; newest first) ---"
    git log --since=36.hours --format='%h %ar %s' 2>/dev/null | cut -c1-105 | head -14
  else
    last=$(git log -1 --format='%h %ar %s' 2>/dev/null | cut -c1-105)
    [ -n "$last" ] && echo "No commits in the last 36h. Last: $last"
  fi
  echo "Uncommitted files: $(git status --porcelain 2>/dev/null | wc -l | tr -d ' ') · branch: $(git branch --show-current 2>/dev/null)"

  # Unwrapped-session snapshot (written at SessionEnd/PreCompact; wrap deletes it)
  if [ -f .claude/.session-snapshot.md ]; then
    echo "--- Unwrapped session snapshot ---"
    head -4 .claude/.session-snapshot.md
  fi

  # Session notes (written by /wrap, one note per chat, newest first): show the last 36h,
  # always at least the newest. Older-format single digest → its head.
  if [ -f .claude/.last-session.md ]; then
    echo "--- Lately (session notes, newest first) ---"
    if grep -q '^## ' .claude/.last-session.md; then
      cutoff=$(date -v-36H '+%Y-%m-%d %H:%M' 2>/dev/null || date -d '36 hours ago' '+%Y-%m-%d %H:%M' 2>/dev/null)
      awk -v c="$cutoff" '
        /^## /{ n++; ts=""; if (match($0,/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]( [0-9][0-9]:[0-9][0-9])?/)) ts=substr($0,RSTART,RLENGTH);
                keep=(n==1 || ts>=c); l=0 }
        keep && l<7 { print; l++ }' .claude/.last-session.md | cut -c1-300 | head -c 2500
      echo
    else
      head -8 .claude/.last-session.md | cut -c1-300
    fi
  fi

  # Research briefs available (most recent five)
  ls -t .claude/research/*.md 2>/dev/null | head -5 | while read -r b; do echo "Brief: $b"; done

  # Roadmap: goal + Now items (what we think comes next), capped
  if [ -f .claude/ROADMAP.md ]; then
    echo "--- Roadmap: Now ---"
    awk '/^## (Next|Later|Details)/{exit}
         /^## Goal/{print; if((getline l)>0 && l!="") print l; next}
         /^## Now/{print; next}
         /^[0-9]+\.|^- /{print}' .claude/ROADMAP.md | cut -c1-200 | head -10 | head -c 1600
    echo
  fi

  # ARCHITECTURE Map section only (exact-match start, exit at next ## section), capped
  if [ -f .claude/ARCHITECTURE.md ]; then
    echo "--- Map ---"
    awk 'f&&/^## /{exit} /^## Map$/{f=1} f' .claude/ARCHITECTURE.md | head -40 | head -c 2400
    echo
  fi

  # Once-weekly vibeflow update check (fail-silent, compares the installed branch)
  D="$HOME/.claude/skills/vibeflow"; S="$D/.last-update-check"
  if [ -d "$D/.git" ] && [ "$(cat "$S" 2>/dev/null)" != "$(date +%G-%V)" ]; then
    date +%G-%V > "$S" 2>/dev/null
    BR=$(git -C "$D" rev-parse --abbrev-ref HEAD 2>/dev/null)
    L=$(git -C "$D" rev-parse HEAD 2>/dev/null)
    R=$(git -C "$D" ls-remote -q origin "$BR" 2>/dev/null | awk 'NR==1{print $1}')
    [ -n "$R" ] && [ "$L" != "$R" ] && echo "vibeflow update available — run: bash ~/.claude/skills/vibeflow/update"
  fi

  # Hook-copy drift check (/bootstrap installs copies; they don't self-update — trust gradient).
  # Prints a nudge for Claude to surface; never overwrites (the copy may be deliberately customized).
  drift=""
  for h in session-start.sh session-snapshot.sh; do
    [ -f ".claude/hooks/$h" ] && [ -f "$D/hooks/$h" ] && ! cmp -s ".claude/hooks/$h" "$D/hooks/$h" && drift="$drift $h"
  done
  [ -n "$drift" ] && echo "Hook copies differ from the vibeflow pack:$drift — offer to refresh (cp from ~/.claude/skills/vibeflow/hooks/), or diff first if this project customized them"

  echo "</vibeflow-orientation>"
)

# Hard cap: 9KB — above ~10KB the harness spills hook output to a file (2KB preview)
echo "$OUT" | head -c 9000
exit 0
