---
name: start
description: Begin or resume a work session — orients on project state, then routes to resuming an in-flight sprint, planning a new sprint (research-driven), or building directly (Freebuild). Use at the start of a session, when the user asks "where were we" / "what's next" / "let's keep going" / "continue where we left off", or when they name a roadmap item to work on. Requires vibeflow state in `.claude/` (else point to `/bootstrap`).
---

# /start

Read `~/.claude/skills/vibeflow/CORE.md` (or `CORE.md` at the vibeflow pack root, wherever it's installed) first (skip if already in context). Stance for this mode: **turn rough intent into a grounded approach before any code — planning is the expensive-to-reverse part; code is cheap to redo.**

Second principle: **stay forward-oriented.** Aim for the minimum version of the goal running, not a flawless version of every step. Park worthwhile extras on the roadmap rather than folding them in; finalizing can be its own later sprint.

## Orient (silent)

The SessionStart hook usually injects orientation (project identity, Map, roadmap top, sprint status, work-since-last-wrap). Don't re-read what's already injected. Fill gaps silently, in one parallel batch: sprint files for detail, `~/.claude/vibeflow/playbook.md` (global profile), `.claude/.last-session.md` if present. If no `<vibeflow-orientation>` block was injected (hook not installed), read the orientation yourself in the same batch: PROJECT.md, ARCHITECTURE's Map section, ROADMAP top, sprint status.

If `.claude/` has no vibeflow state, offer in one line: "This project isn't set up for vibeflow yet — want me to set it up now?" On yes, run `/bootstrap` directly.

**Verify before briefing — proportional to the gap.** Sprint files are claims; the repo is truth. If the orientation shows nothing committed since the last wrap and a clean tree, trust the files and skip reconciliation. When there IS a gap (commits since wrap, uncommitted work, another chat active), check `git log` since the last wrap commit — where a sprint file and the repo disagree (steps shipped but unchecked, work landed in another chat), the brief says so plainly: "sprint file says X pending; git shows it shipped in `<hash>`." Never brief confidently from a file the diff contradicts.

Then brief in ~10 seconds of reading:

```
Project: <one line>        Goal: <from ROADMAP>
Sprints: <name — N/M done — one-line real state>  [or "none active"]
Now: <top 1-2 roadmap items>
Last session: <one sentence, incl. where iteration stalled if noted>
```

Route with one AskUserQuestion: resume (an option per in-flight sprint), pull from roadmap, plan something new, or Freebuild. Shape the options to reality — a completed sprint offers "wrap & archive" instead; no sprints means no resume option; if the sprints plus routes exceed the 4-option cap, collapse resumes into one "Resume a sprint…" option and disambiguate in a follow-up. Label options in plain language — "Just build, no plan needed" for Freebuild.

## Resume and Freebuild → build, now

Don't end the turn telling the user to type `/build`. On **Resume**, or **Freebuild** with a stated target: confirm the next step in one line, read `~/.claude/skills/vibeflow/build/SKILL.md`, and continue working in this session under its rules. Only pause if the route genuinely needs input (Freebuild with no target yet: ask what they want to work on).

## Plan a sprint (pull-from-roadmap or something new)

The job: from vague intent to an approach a fresh `/build` could run cold. In this mode your outputs are questions, research findings, and approach options — code starts after the approach is confirmed and plan mode approves the plan.

### 1 — Sharpen the target

Open with `## Sprint planning: <topic>` (≤6 words).

If the target is a roadmap item, pull its top line + its Details block + its research brief (`research/<slug>.md`) if one exists, and read the goal and what's queued after it — you're planning to fit the trajectory. Play the item back and ask what's changed.

Sharpen until the target is defined well enough to research: the user experience step-by-step, the why, what success looks like, the edges that matter. These are goals, not a script — a small sprint may need one question, a fuzzy one several rounds. Group related questions and attach a lean ("I'd go (a) because…") so the user reacts instead of answering cold. Then synthesize back in a few lines and confirm before researching.

If the intent bundles multiple independent goals, read [references/sequencing.md](references/sequencing.md) and propose a lineup — plan only Sprint 1 today.

### 2 — Research the approach

This stage prevents "we shipped a worse approach because we never looked at how it's done." Don't plan a meaningful feature from priors alone; skip research only when the approach is genuinely routine for this codebase.

- A brief at `research/<slug>.md` is the fast path — use it, refresh only what's stale.
- Otherwise: read the relevant project code + ARCHITECTURE + the area's DECISIONS entries, and search the web for how this is done well and the known pitfalls. Decide yourself whether to work inline or spawn a research subagent (Explore for codebase fan-out, general-purpose for web, the deep-research skill for a genuinely large unknown) — no permission needed for internal work.
- Never describe our existing code from memory — open the file. Options must rest on what the code actually does.

### 3 — Decide the approach

Present 2–3 options from first principles as Decision cards (CORE.md format), each grounded in a citation — a source or `path:line`. This is the headline decision of the sprint; the user picks.

- **Fit the path:** pick the minimal approach the known near-term roadmap won't force you to rip out — lean execution, goal-aware direction.
- **Challenge inferred infrastructure:** if the shape adds a route/table/flag/reimplementation the user never stated, surface it as its own Decision — the simplest shape meeting the stated goal wins unless they confirm the addition.
- If the sprint has grown past the item's original intent, say so and offer: trim, accept, or split.

Keep a visible "Decisions so far" list as options resolve. On a greenfield project's first sprint, the stack itself is this decision — research and recommend it here.

### 4 — Plan mode (the single gate)

When the approach is confirmed, enter plan mode (`EnterPlanMode`). Inside:

- **Ground the load-bearing claims** — read the source files the approach depends on; cite `path:line`. These go in the sprint's Ground truth and are what keep `/build` from inventing things.
- **Produce the plan**: goal, approach, scope in/out, and coarse outcome-steps with checkpoints, per [references/sprint-md-shape.md](references/sprint-md-shape.md) (read it now). Tag steps `[PORT]`/`[NEW]`/`[REUSE]`; mark a checkpoint only where a later step genuinely depends on this one being right.

`ExitPlanMode` with the full plan — goal, approach, scope, steps. That approval is the one plan gate; there is no separate pre-plan confirmation.

### 5 — Write the sprint and go

Write the approved plan to `.claude/sprints/<slug>.md` (kebab-case; new filename if it collides — never overwrite an in-flight sprint). On a greenfield first sprint, also seed ARCHITECTURE.md from the stack decision (Map-on-top; template at `../templates/ARCHITECTURE.md`).

Then flow straight into building under `/build`'s rules unless the user said they're stopping here — in that case: "Sprint written to `.claude/sprints/<slug>.md` — pick it up anytime."
