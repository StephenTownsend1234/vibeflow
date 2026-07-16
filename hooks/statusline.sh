#!/bin/bash
# vibeflow statusline — <dir> · <branch> · 🏃 <sprint> N/M
# Reads Claude Code's statusline JSON from stdin; degrades gracefully anywhere.
input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // empty' 2>/dev/null)
[ -z "$cwd" ] && cwd="$PWD"
cd "$cwd" 2>/dev/null

line=$(basename "$cwd")
branch=$(git branch --show-current 2>/dev/null)
[ -n "$branch" ] && line="$line · $branch"

if [ -d .claude/sprints ]; then
  count=0; name=""; prog=""
  for f in .claude/sprints/*.md; do
    [ -f "$f" ] || continue
    total=$(grep -cE '^[[:space:]]*- \[[ xX]\]' "$f" 2>/dev/null)
    [ "${total:-0}" -eq 0 ] && continue
    done_=$(grep -cE '^[[:space:]]*- \[[xX]\]' "$f" 2>/dev/null)
    if [ "$done_" -lt "$total" ]; then
      count=$((count+1)); name=$(basename "$f" .md); prog="$done_/$total"
    fi
  done
  if [ "$count" -eq 1 ]; then line="$line · 🏃 $name $prog"
  elif [ "$count" -gt 1 ]; then line="$line · 🏃 $count sprints in flight"
  fi
fi

printf '%s' "$line"
