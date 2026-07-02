---
name: bootstrap
description: One-time vibeflow setup for a project — scans the repo (or goes conversation-first when greenfield), captures the vision, maps the path via /roadmap, scaffolds the `.claude/` state files, and installs the SessionStart orientation hook. Use when a project has no vibeflow state yet, when the user asks to set up vibeflow here, or when older vibeflow files need migrating to the current shape.
---

# /bootstrap

Read `~/.claude/skills/vibeflow/CORE.md` first. Stance: **scan deeply on architecture, ask openly on product — code reveals the stack, never the vision.**

Be a guide, not a technician: say plainly what you're doing and why it helps; keep internal jargon out of the user's view. Ask product questions one at a time, conversationally.

## 1 — Detect the scenario

- **Existing project** (real source + manifests): full flow below.
- **Greenfield** (empty / README only): skip the scan; go conversation-first from step 3. Don't propose a stack — that's a researched decision in the first `/start`.
- **Existing `.claude/`**: vibeflow files already there? If they're in an older shape (date-ordered append-only DECISIONS, single-tier ROADMAP, a PLAYBOOK.md, monolithic ARCHITECTURE), this is a **migration** — offer it and read [references/migrate-v1.md](references/migrate-v1.md) plus the v3 file shapes in `../templates/`. Only harness files → treat as fresh; they coexist fine.
- Related work nearby (a sibling project, an old plan doc)? Ask before reading it in — a new project is a clean slate unless the user says otherwise.

On first-ever vibeflow use (no `~/.claude/vibeflow/playbook.md`): create it from `../templates/global-profile.md`. Don't interview for working style — the Working preferences block fills itself from observed corrections at `/wrap`.

Open with a short, warm intro of what setup does and the loop (`/start` → build → `/wrap`, `/roadmap` anytime) in your own words — no script.

## 2 — Scan (existing projects)

Scan deeply for architecture: manifests, configs, schema/migrations, the folder tree, and one exemplar file per convention — skip tests and build outputs. If a real architecture doc already exists, use it as the base and layer scan findings on top (a mixed current-state+history blob gets split per the migration reference, not ingested whole).

Share findings in the shape the doc will take — Map first (stack / external services / where things live / key patterns), then detail (data model, routes, gotchas, open questions) — and iterate until the user says it's right.

## 3 — Capture the vision

The part only the user can give. One at a time, following up when an answer is thin:

1. "In your own words, what is this project — and the bigger vision behind it?"
2. "Who is it for?"
3. "What phase are you in — discovery, build, launch, iterate, maintain?" (Greenfield: "and how will it run — web, mobile, CLI…?")
4. "What does success look like — the north star?"
5. "Any locked decisions or constraints worth capturing?" (Record as facts.)

Leave blanks as `<TBD>` — never fabricate.

**Then always run `/roadmap`** (read `../roadmap/SKILL.md`, "called from bootstrap" mode): the vision says where; the roadmap makes the path. Fold its Goal + Now/Next/Later back into your draft.

## 4 — Write the scaffold

Write directly from the templates in `../templates/` — creation isn't overwriting, and editing a written file is as cheap as editing a draft (the confirm-before-write reflex protects *existing* state only):

- `PROJECT.md`, `ARCHITECTURE.md` (Map on top; greenfield gets a stub — the first `/start` seeds it), `ROADMAP.md` (two-tier), `DECISIONS.md` (area registry, from Q5), `sprints/archive/`.
- **Install the SessionStart hook**: copy `~/.claude/skills/vibeflow/hooks/session-start.sh` to `.claude/hooks/session-start.sh` (executable) and register it in `.claude/settings.json` under `hooks.SessionStart` (command type, `$CLAUDE_PROJECT_DIR/.claude/hooks/session-start.sh`). Merge into existing settings — don't clobber. This is what makes every future session start oriented without ceremony.

Then invite edits: "Review these — what's wrong, what's missing?" Revise until solid.

Close: "Foundation set and roadmap mapped — run `/start` to plan your first sprint." Offer the background routine (Ship Captain + Ship Spotter, `../roadmap/references/background-routine.md`) in two lines; set it up via `/schedule` on yes, note it's available from `/roadmap` anytime on no.

## Edge cases

Monorepo: ask which app the `.claude/` scopes to. Thin project: shrink the scan, lean on the vision Q&A. User bails mid-flow: offer to save drafts to `.claude/drafts/`.
