# Migrating v2 vibeflow state to v3

For a project whose `.claude/` is in the v2 shape (Map-on-top ARCHITECTURE, date-ordered append-only DECISIONS, single-tier ROADMAP, a per-project PLAYBOOK.md). Reorganizes `.claude/` markdown only; preserve originals in `.claude/archive/` as `<name>-pre-v3.md`. Collaborate — draft each file, confirm, go file by file.

## DECISIONS: date log → area registry

Group the existing entries under area headings mirroring ARCHITECTURE's sections. Per topic, **merge duplicates and resolve contradictions** (two entries on the same incident: keep one, fold the correction in; ask the user which mechanism holds when unclear). Compress each surviving entry to Chose/Because, ≤6 lines, keeping its date in the heading. Strip transient states ("not yet deployed") — verify against reality and either drop or move to a sprint TO-DO. Sprint-batch dump entries ("8 decisions captured"): promote the 1–2 project-shaping calls into their areas; the rest stay in the archived sprint.

## ROADMAP: single tier → two tiers

Top: Goal + Now/Next/Later as strict one-liners with `[→ details]` markers. Move each item's context blurb into `## Details / ### <slug>`. Delete shipped-but-listed items (top + blurb); cap Done at ~10 lines; remove cross-section pointers. Keep capture dates on Later items.

## PLAYBOOK.md: retire

Route each entry by content: project-specific what-worked → DECISIONS (it's rationale) or an ARCHITECTURE gotcha; cross-project lessons → the global profile's Lessons section. Then delete the file. Ensure `~/.claude/vibeflow/playbook.md` has the v3 two-section shape (`templates/global-profile.md`) — add the Working preferences block if missing, seeding it from what you know of the user.

## ARCHITECTURE: keep, spot-clean

Shape is unchanged. While touching it: re-verify the Map's greppable claims against code (model IDs, live tables, cleared blockers), and strip any `file:line` citations from living sections (keep the lesson, drop the literal).

## Install the hook

Copy `~/.claude/skills/vibeflow/hooks/session-start.sh` into `.claude/hooks/` and register it exactly as bootstrap's "Install the SessionStart hook" step shows (`../SKILL.md`) — v2 projects predate it.

In-flight sprint files: leave untouched. New sprints get the v3 shape via `/start`.
