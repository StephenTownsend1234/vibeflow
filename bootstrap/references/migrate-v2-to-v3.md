# Migrating v2 vibeflow state to v3

For a project whose `.claude/` is in the v2 shape (Map-on-top ARCHITECTURE, date-ordered append-only DECISIONS, single-tier ROADMAP, a per-project PLAYBOOK.md). Reorganizes `.claude/` markdown only; preserve originals in `.claude/archive/` as `<name>-pre-v3.md`. Collaborate — draft each file, confirm, go file by file. A migration replaces the rest of the bootstrap flow: PROJECT and the vision already exist, so don't re-run the scan or Q&A.

## Pre-flight

- **Wrap first, migrate clean.** If the orientation or `.session-snapshot.md` shows unwrapped work, run `/wrap` before migrating — reorganizing files a pending wrap still needs to update loses attribution. Also confirm the git tree is committed, so the migration lands as one isolated, revertable diff.
- **These files can be large** (a mature project's DECISIONS can run 50–80KB). Work **section by section with confirmation**, not in one monolithic rewrite — and where content survives unchanged, *move* it rather than retyping it; re-synthesis is where fidelity drifts. The distill rules (condense, never cut) apply only where entries actually merge.
- **User-created domain files stay untouched.** Anything beyond the five state files — a DESIGN.md, config files like `launch.json`, the `research/` briefs — is canon the user built; it is not part of this reorganization.

## DECISIONS: date log → area registry

Group the existing entries under area headings mirroring ARCHITECTURE's sections. Per topic, **merge duplicates and resolve contradictions** (two entries on the same incident: keep one, fold the correction in; ask the user which mechanism holds when unclear). Compress each surviving entry to Chose/Because, ≤6 lines, keeping its date in the heading. Strip transient states ("not yet deployed") — verify against reality and either drop or move to a sprint TO-DO. Sprint-batch dump entries ("8 decisions captured"): promote the 1–2 project-shaping calls into their areas; the rest stay in the archived sprint.

## ROADMAP: single tier → two tiers

Top: Goal + Now/Next/Later as strict one-liners with `[→ details]` markers. Move each item's context blurb into `## Details / ### <slug>`. Delete shipped-but-listed items (top + blurb); cap Done at ~10 lines; remove cross-section pointers. Keep capture dates on Later items.

## PLAYBOOK.md: retire

Route each entry by content: project-specific what-worked → DECISIONS (it's rationale) or an ARCHITECTURE gotcha; cross-project lessons → the global profile's Lessons section. Then delete the file. Ensure `~/.claude/vibeflow/playbook.md` has the v3 two-section shape (`templates/global-profile.md`) — add the Working preferences block if missing, seeding it from what you know of the user.

## ARCHITECTURE: keep, spot-clean

Shape is unchanged. While touching it: re-verify the Map's greppable claims against code (model IDs, live tables, cleared blockers), and strip any `file:line` citations from living sections (keep the lesson, drop the literal).

## Hooks

Check first — hooks may already be installed. If present, refresh the script copies from `~/.claude/skills/vibeflow/hooks/` (they may be stale); if absent, install all three and merge the settings block exactly as bootstrap's "Install the hooks" step shows (`../SKILL.md`). Never clobber an existing `settings.json`'s other keys.

## CLAUDE.md demotion pass

Check the project's CLAUDE.md (and a parent repo's, if one routes here) for rules that are **already enforced by a deterministic hook** — e.g. migration-safety prose duplicating a PreToolUse guard. Offer to demote each to a one-line pointer at the hook ("guard: see settings PreToolUse hook"): mechanized rules don't need re-reading every session, and the lingering prose keeps old incidents alive in every conversation. Also flag (don't silently fix) any CLAUDE.md routing that points at retired commands or files the migration moves.

## In-flight sprints

Leave their content untouched — never rewrite mid-flight work. One optional offer, since v3's build reads checkpoint kinds: "want me to tag the live sprints' `→ CHECKPOINT:` markers as `(machine)` or `(human)`? Markers only — no other edits." Only on a yes.

## Finish

One checkpoint commit — `docs(migrate): .claude state → v3 shapes` — covering the reshaped files and the archived originals. Never push. Then verify, cheapest first:

1. **Mechanical:** run the SessionStart hook manually (`CLAUDE_PROJECT_DIR=<project> bash .claude/hooks/session-start.sh`) and confirm the orientation reads sanely; check the ROADMAP top tier is ~40 lines or less; script a representation check (every dated `## YYYY-MM-DD` heading in the archived DECISIONS has its date or a distinctive title keyword somewhere in the new file — catches silently dropped entries).
2. **Blind fidelity exam** (a migration has two failure modes — knowledge loss and introduced drift; this catches the first): one fresh-context agent reads ONLY the archived files and writes ~12 hard questions a future session would need answered (rationales, mechanisms, gotchas, trigger conditions — include several obscure-but-load-bearing details, exclude deliberately-relocated transient states), each with a gold answer. A second fresh agent answers from ONLY the new files. Grade against gold; anything unanswerable or degraded is knowledge the rewrite lost — restore it.
3. **Doc-vs-code sweep** (catches the second failure mode): a fresh agent samples ~12 greppable claims from the reshaped files and verifies each against the repo. Expect it to also surface *inherited* drift the old docs already carried — the migration is the one moment everything is in context, so fix those too, scoped precisely (first run of this on a mature project found a pre-existing overstated claim, not migration damage).

The next `/start` is the real acceptance test.
