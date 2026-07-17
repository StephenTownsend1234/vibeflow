---
name: start
description: Begin or resume a work session — orients on project state, then routes to resuming an in-flight sprint, planning a new sprint (research-driven), or building directly (Freebuild). Use at the start of a session, when the user asks "where were we" / "what's next" / "let's keep going" / "continue where we left off", or when they name a roadmap item to work on. Requires vibeflow state in `.claude/` (else point to `/bootstrap`).
---

# /start

Read `~/.claude/skills/vibeflow/CORE.md` (or `CORE.md` at the vibeflow pack root, wherever it's installed) first (skip if already in context). 

Mode stance: **Planner. Turn rough intent into a grounded approach before any code. Spend planning effort on the decision that's expensive to reverse (the approach), not the work that's cheap to redo (the code)**

Second principle: **stay forward-oriented.** Be eager to start the next sprint, not to blow this one up. Align on scope with the user. Aim for the minimum version of the roadmap goal running. Park extras on the roadmap or ask the user rather than folding them in. Forward momentum, built iteratively. 

## Orient (silent)

The SessionStart hook usually injects orientation (project identity, Map, roadmap top, sprint status lines, last-session carry-forward, work-since-last-wrap). That's enough to brief and route — **don't read full sprint files before the user has picked one**; the hook's title + count + next-step line is the right altitude until a route is chosen. The only silent read now is `~/.claude/vibeflow/playbook.md` (global profile). If no `<vibeflow-orientation>` block was injected (hook not installed), read the orientation yourself in one batch: PROJECT.md, ARCHITECTURE's Map section, ROADMAP top, sprint status.

If `.claude/` has no vibeflow state, offer in one line: "This project isn't set up for vibeflow yet — want me to set it up now?" On yes, run `/bootstrap` directly.

**Verify before briefing — proportional to the gap.** Sprint files are claims; the repo is truth. If the orientation shows nothing committed since the last wrap and a clean tree, trust the files and skip reconciliation. When there IS a gap (commits since wrap, uncommitted work, another chat active), check `git log` since the last wrap commit — where a sprint file and the repo disagree (steps shipped but unchecked, work landed in another chat), the brief says so plainly: "sprint file says X pending; git shows it shipped in `<hash>`." Never brief confidently from a file the diff contradicts.

Then brief in ~10 seconds of reading:

```
Project: <one line>        Goal: <from ROADMAP>
Sprints: <name — N/M done — one-line real state>  [or "none active"]
Now: <top 1-2 roadmap items>
Last session: <one sentence, incl. where iteration stalled if noted>
```

Ask the user what they want to work on. Propose simple options below: resume an ongoing sprint (if any), pull from roadmap, plan a sprint, or Freebuild. Shape the options to reality — a completed sprint offers "wrap & archive" instead; no sprints means no resume option; if the sprints plus routes exceed the 4-option cap, collapse resumes into one "Resume a sprint…" option and disambiguate in a follow-up. 

## Resume and Freebuild → build, now

Invoke the `/build` skill. On **Resume**: Read the chosen sprint file (just that one) + `~/.claude/skills/vibeflow/build/SKILL.md`. If the sprint has one clear next step and its ground truth is current, confirm in one line and keep going. But if it has **several open tasks, stale checkboxes, or grounding that predates real commits** — common on long-running sprints — that confirm is a real question, and you wait: "Next per the file is <task>; the sprint also has <B/C/F> open. That one, or something else? Anything changed since this was planned?" The user often resumes a sprint *with a specific task and fresh context in mind* — draw that out before spending minutes re-grounding a task they didn't pick. **Freebuild** with a stated target: Invoke the `/build` skill and go. Only pause if the route genuinely needs input (Freebuild with no target yet: ask what they want to work on).

## Plan a sprint (pull-from-roadmap or something new)

The job is to get from vague intent to an well-planned approach, delivering a plan a fresh `/build` session could run cold. In this mode your outputs are questions, research findings, and approach options — code starts after the user confirms the approach and plan mode approves the plan.

### 1 — Gather (the user's context is the sprint's raw material)

Open with `## Sprint planning: <topic>` (≤6 words).

The best research can't recover what only the user knows — what they're imagining, what they've seen work elsewhere, what they dread, what done looks like. The goal is a target defined well enough to research an approach for. Sprint quality is capped by how much of that you draw out before researching and planning, so draw it out. Help the user sharpen and scope their intent.  **If the user has barely spoken and you're filling the silence with your own choices, you're deciding their sprint for them — stop and ask.**

If the target is a roadmap item, pull its top line + its Details block + its research brief (`research/<slug>.md`) if one exists, and read the goal and what's queued after it — you're planning to fit the trajectory. Play the item back and ask what's changed.

The rhythm (goals to hit in whatever order fits — a small sprint may need just a few questions, a fuzzy one several rounds). Scale the ceremony to the work. Examples a full sharpening session might work through:
- **Invite the dump first:** "tell me everything in your head about this — rough and unordered is fine." Then play it back in a short paragraph and let them correct you.
- **Play it back** - Restate the feature as a single concrete sentence describing the user's step-by-step experience. Surface questions they didn't state (triggers, timing, sequence). 
- **Understand the why/problem** - What does this get the user that the current way doesn't?Clarify the what - Pin down the loop, ask clarifying questions on how this works for the user.
- **Test an edge** - Surface what happens when something breaks and ask about it.
- **Invite the dump first:** "tell me everything in your head about this — rough and unordered is fine." Then play it back in a short paragraph and let them correct you.
- **For user-facing work, walk the experience before any tech:** first contact, the happy path, the moment something goes wrong, what it says and in whose voice. Experience forks usually decide the technical forks — surface them first.
- **Alternate, don't interview:** themed rounds of 2–3 questions with your lean attached ("I'd go (a) because…"), interleaved with what you're learning from the roadmap and a quick look at the code — back-and-forth, not a form and not a monologue.

Then synthesize what you heard in a few lines and confirm before researching.

If the intent bundles multiple independent goals, read [references/sequencing.md](references/sequencing.md) and propose a lineup — plan only Sprint 1 today.

### 2 — Research the approach

This stage prevents "we shipped a worse approach because we never looked at how it's done." Don't plan a meaningful feature from priors alone; skip research only when the approach is genuinely routine for this codebase.

- A brief at `research/<slug>.md` is the fast path — use it, refresh only what's stale.
- Otherwise: read the relevant project code + ARCHITECTURE + the area's DECISIONS entries, and search the web for how this is done well and the known pitfalls. Decide yourself whether to work inline or spawn a research subagent (Explore for codebase fan-out, general-purpose for web, the deep-research skill for a genuinely large unknown). **Keep delegation one level deep:** prefer Explore agents for fan-out (they can't spawn sub-agents); when a general-purpose researcher is genuinely needed, instruct it not to spawn its own — you own the fan-out and the synthesis.
- Never describe our existing code from memory — open the file. Options must rest on what the code actually does.

### 3 — Decide the approach

Present options from first principles as Decision cards (CORE.md format), each grounded in what you found - a citation, a source or `path:line`. This is the headline decision of the sprint; the user picks.

- **Fit the path:** Recommend the approaches the known near-term roadmap won't force you to rip out — lean execution, goal-aware direction.
- **Challenge inferred infrastructure:** if the shape adds a route/table/flag/reimplementation the user never stated, surface it as its own Decision — the simplest shape meeting the stated goal wins unless they confirm the addition.
- If the sprint has grown past the item's original intent, say so and offer: trim, accept, or split.

Keep a visible "Decisions so far" list as options resolve. On a greenfield project's first sprint, the entire tech stack itself is this decision — research and recommend it here with the roadmap goal in view.

### 4 — Plan mode (the single gate)

When the approach is confirmed, enter plan mode (`EnterPlanMode`). Inside:

- **Ground the load-bearing claims** — read the source files the approach depends on; cite `path:line`. These go in the sprint's Ground truth and are what keep `/build` from inventing things.
- **Produce the plan**: goal, approach, scope in/out, and coarse outcome-steps with checkpoints, per [references/sprint-md-shape.md](references/sprint-md-shape.md) (read it now). Tag steps `[PORT]`/`[NEW]`/`[REUSE]`; mark a checkpoint only where a later step genuinely depends on this one being right.

`ExitPlanMode` with the full plan — goal, approach, scope, steps. That approval is the one plan confirmation gate.

### 5 — Write the sprint and go

The harness saves the approved plan to `.claude/plans/<file>.md` — **`cp` it to `.claude/sprints/<slug>.md`** (kebab-case; new filename if it collides — never overwrite an in-flight sprint): exact fidelity to what was approved, zero re-synthesis. Then one `Edit` pass: add the Status header (run mode, date, 0/N steps) and make sure steps are `- [ ]` checkboxes (the SessionStart hook counts them). Only `Write` from memory if no saved plan file exists. On a greenfield first sprint, also seed ARCHITECTURE.md from the stack decision (Map-on-top; template at `../templates/ARCHITECTURE.md`).

If the plan touches a migration, a native module, or a live prompt/function, suggest running the sprint on a branch (`sprint/<slug>`) — one motion to abandon if verification fails; small low-risk work stays on main.

Then flow straight into building. Invoke `/build`' mode and follow it's rules unless the user said they're stopping here — in that case: "Sprint written to `.claude/sprints/<slug>.md` — pick it up anytime."
