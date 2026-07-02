---
name: bootstrap
description: One-time vibeflow setup for a project — scans the repo (or goes conversation-first when greenfield), captures the vision, maps the path via /roadmap, scaffolds the `.claude/` state files, and installs the SessionStart orientation hook. Use when a project has no vibeflow state yet and the user asks to set it up — or asks in plain terms for help building, finishing, or continuing a project ("help me finish my app"): offer setup in one line before diving into code. Also handles migrating older vibeflow file shapes.
---

# /bootstrap

Read `~/.claude/skills/vibeflow/CORE.md` (or `CORE.md` at the vibeflow pack root, wherever it's installed) first. Stance: **scan deeply on architecture, ask openly on product — code reveals the stack, never the vision.**

Be a guide, not a technician: say plainly what you're doing and why it helps; keep internal jargon out of the user's view. Ask product questions one at a time, conversationally.

## 1 — Detect the scenario

- **Existing project** (real source + manifests): full flow below.
- **Greenfield** (empty / README only): skip the scan; go conversation-first from step 3. Don't propose a stack — that's a researched decision in the first `/start`.
- **Existing `.claude/`**: vibeflow files already there? Route by shape: a **pre-v2 monolith** (one accreted ARCHITECTURE mixing state + history + decisions) → [references/migrate-v1.md](references/migrate-v1.md), then finish with [references/migrate-v2-to-v3.md](references/migrate-v2-to-v3.md); the **v2 shape** (date-ordered append-only DECISIONS, single-tier ROADMAP, a PLAYBOOK.md) → [references/migrate-v2-to-v3.md](references/migrate-v2-to-v3.md) directly. Already in the v3 shape → ask in one line: merge/refresh or cancel — never re-scaffold over live state. Only harness files → treat as fresh; they coexist fine.
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
5. "Anything you've already decided you definitely want — or definitely don't?" (Record as facts.)

Leave blanks as `<TBD>` — never fabricate. Afterwards, seed one Working-preferences bullet in the global profile from what this conversation revealed about their technical level and style — you just spent a whole conversation observing them.

**Then always run `/roadmap`** (read `../roadmap/SKILL.md`, "called from bootstrap" mode): the vision says where; the roadmap makes the path. Fold its Goal + Now/Next/Later back into your draft.

## 4 — Write the scaffold

Write directly from the templates in `../templates/` — creation isn't overwriting, and editing a written file is as cheap as editing a draft (the confirm-before-write reflex protects *existing* state only):

- No git repo (`git rev-parse --is-inside-work-tree` fails)? Offer plainly — "I'll turn on change-tracking so progress gets saved between sessions; one command, all local" — and run `git init` + an initial commit on yes.
- `PROJECT.md`, `ARCHITECTURE.md` (Map on top; greenfield gets a stub — the first `/start` seeds it), `ROADMAP.md` (two-tier), `DECISIONS.md` (area registry, from Q5), `sprints/archive/`.
- **Install the SessionStart hook**: copy `~/.claude/skills/vibeflow/hooks/session-start.sh` to `.claude/hooks/session-start.sh` (executable) and merge this exact block into `.claude/settings.json` (merge keys — don't replace an existing `hooks` object):
  ```json
  {"hooks": {"SessionStart": [{"hooks": [{"type": "command", "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/session-start.sh"}]}]}}
  ```
  This is what makes every future session start oriented without ceremony.
- **Runnable app?** Offer to run the harness's `/run-skill-generator` once — it records the launch recipe as a per-project skill that `/run` and `/verify` follow, which is what makes /build's machine checkpoints able to verify against the real app. Note the one-liner in the Map's Run & verify line.

Then offer lightly: "I've written the project files — want a tour, or shall we keep moving?" Walk through and revise on a tour; don't force a doc review on a beginner.

Close by keeping the momentum: "Foundation set and roadmap mapped — want to plan your first piece of work right now?" On yes, read `../start/SKILL.md` and continue in-session. (The background routine is offered at the project's first `/wrap`, not here — they've answered enough questions today.)

## Edge cases

Monorepo: ask which app the `.claude/` scopes to. Thin project: shrink the scan, lean on the vision Q&A. User bails mid-flow: offer to save drafts to `.claude/drafts/`.
