---
name: vibeflow
description: Overview of the vibeflow workflow suite — a vibe-coder's system for building, shipping, and iterating on software with Claude. The individual commands are registered as separate skills (`/bootstrap`, `/start`, `/build`, `/wrap`, `/roadmap`); this skill is the shared reference for how they connect and the `.claude/` files they share. Do not trigger on a slash command — defer to the per-command skills.
---

# vibeflow

A workflow suite for a founder building software with Claude. Five commands sharing a common `.claude/` state system.

## The commands

| Command | Purpose | When |
|---|---|---|
| `/bootstrap` | One-time setup — captures the vision, maps the path (`/roadmap`), scaffolds `.claude/` | First time in a repo |
| `/start` | Orient, then resume / plan a sprint / **Freebuild** (iterate directly) | Every session |
| `/build` | Execute the work (or pick up warm from `/start`) | After planning, or to iterate |
| `/wrap` | Save the session to the files so the next one starts smarter | End of session |
| `/roadmap` | The path to your goal — capture ideas, order Now/Next/Later | Anytime priorities shift |

Plus an opt-in **background routine** (see `roadmap/references/background-routine.md`): **Ship Captain** (checks your progress and keeps you aligned on the goal) and **Ship Spotter** (researches upcoming roadmap items ahead of time).

## How they connect

```
/bootstrap (once) ─▶ /roadmap (order the path) ─▶ /start ─┬─ resume ──▶ /build ──▶ /wrap
                                                          ├─ plan ─────▶ /build ──▶ /wrap
                                                          └─ Freebuild ─(iterate here)─▶ /wrap

(background, opt-in)  Ship Captain ──▶ progress check toward your goal
                      Ship Spotter ──▶ .claude/research/<slug>.md ──▶ used by /start
```

## Shared `.claude/` files

```
.claude/
  PROJECT.md         # what this is, who it's for, phase, north star
  ARCHITECTURE.md    # Map on top (stack / services / where things live / patterns), detail below
  ROADMAP.md         # Goal + Now / Next / Later — the path to the goal
  DECISIONS.md       # choices + rationale — how we got here (living, revisable; not locked)
  PLAYBOOK.md        # what worked well — endorsed patterns, for positive reinforcement
  sprints/
    <slug>.md        # current sprint(s); created by /start
    archive/         # completed sprints, via /wrap
  research/          # pre-sprint briefs from Ship Spotter (lazily read)
  plans/             # plans the harness saved at ExitPlanMode
```

Each file answers one question for a fresh session: PROJECT (what/who), ARCHITECTURE (how it's built + facts learned), ROADMAP (what's next), DECISIONS (why we got here), PLAYBOOK (how we work well), the sprint (current work + progress).

Templates for the bootstrap-created files are in `templates/` — read one only when creating that file the first time.

## Shared role

Every mode opens with the same base `<role>` (the vibe-coder's-master-assistant identity) followed by a one-line mode stance (planning / build / setup / strategist / closer). The role aspires big; each mode's own scope-discipline rules keep execution lean.

## Global principles (all modes)

- **Slash commands only.** Don't trigger on natural-language phrasing — wait for the explicit command.
- **Synthesize, don't dump.** Distill state files into briefs; never paste file contents back.
- **Draft before writing.** Propose changes inline; write to `.claude/` only after the user confirms.
- **Protect the user's flow.** Match check-in frequency to what they're doing — don't interrupt needlessly, don't go silent too long.
- **Surface structural changes.** Never silently rewrite ARCHITECTURE or DECISIONS — propose, then confirm.
- **Capture good examples.** When the user gives genuine, specific praise (or says "record this"), offer to save the transferable lesson to PLAYBOOK.md.

## Dispatching

Each command is its own registered skill, triggered by its slash command; the harness loads that skill directly. This overview is shared reference, not a dispatcher — don't trigger it on a slash command. `/bootstrap` always invokes `roadmap` to map the path before writing the scaffold.

## When `.claude/` doesn't exist

If the user runs `/start`, `/build`, `/wrap`, or `/roadmap` before `/bootstrap`:

> "No `.claude/` folder yet. Run `/bootstrap` first to set up state for this project."

`/bootstrap` is the only mode that works without an existing `.claude/`.
