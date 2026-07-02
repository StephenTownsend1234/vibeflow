# vibeflow

A kit of Claude Code skills for building real products across many sessions: plan collaboratively, build autonomously, and save progress so every session picks up more informed than the last.

## The guiding principle

**Ask when the answer changes *what* gets built; build when it only changes *how*.** Genuine forks get one clear decision with a recommendation; everything inside a confirmed direction runs autonomously; assumptions get surfaced, never silently built on.

## New here? Two commands.

You only need to remember two: **`/start`** when you sit down, **`/wrap`** when you're done. Everything else happens in flow — setup is offered the first time you `/start` an unconfigured project, building begins automatically once a plan is agreed, and saying things like "add X to the roadmap" or "let's wrap up" just works without slash commands.

## The commands

| Command | What it does | When |
|---|---|---|
| `/start` | Orients (the session-start hook already loaded your state), then routes: resume, plan a sprint, or Freebuild — and flows straight into building | Every session |
| `/build` | Executes — one-shot by default after a good plan, fresh-context verifiers on checkpoints, guardrails on scope | Building |
| `/wrap` | Saves the session: reconciles sprints against the real diff, re-verifies docs in touched areas, routes each fact to its one home, checkpoint-commits | Session end |
| `/roadmap` | Zero-ceremony idea capture + ordering the path (Now/Next/Later) toward a concrete goal | Anytime |
| `/bootstrap` | One-time setup: scan, vision, roadmap, scaffold `.claude/`, install the orientation hook | Once per project |

## What lives in your project

```
.claude/
  PROJECT.md       # what this is, who it's for, phase, north star
  ARCHITECTURE.md  # Map on top (orientation), detail + gotchas below
  ROADMAP.md       # path in one-liners on top; item details below the fold
  DECISIONS.md     # why things are the way they are — a registry by area, not a diary
  sprints/         # current + archived sprints
  research/        # pre-sprint briefs, written ahead of time by Ship Spotter
  hooks/           # session-start.sh — injects orientation into every session
```

Plus a global profile at `~/.claude/vibeflow/playbook.md`: your working preferences (maintained from observed corrections) and cross-project lessons.

## Background routine (opt-in)

A daily local routine: **Ship Captain** checks progress against your goal; **Ship Spotter** researches upcoming roadmap items autonomously and writes briefs — with its assumptions listed on top so you can correct them in one reply. By the time you plan an item, the homework's done.

## Install

```bash
git clone --depth 1 https://github.com/StephenTownsend1234/vibeflow.git ~/.claude/skills/vibeflow && cd ~/.claude/skills/vibeflow && bash setup
```

Then open Claude Code in a project and run `/bootstrap`. Update anytime with `bash ~/.claude/skills/vibeflow/update`.

## License

MIT — see [LICENSE](LICENSE).
