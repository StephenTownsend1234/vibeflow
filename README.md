# vibeflow

**A vibe-coding workflow for [Claude Code](https://claude.com/claude-code) — stay in flow from idea to shipped.**

vibeflow is a suite of slash-command skills that gives Claude the structure to plan, build, and *remember* a software project with you. State lives in a `.claude/` folder you own, so every session picks up smarter than the last.

Built for founders and solo builders who code with Claude and want momentum without losing the plot.

## The commands

| Command | What it does | When |
|---|---|---|
| `/bootstrap` | One-time setup — scaffolds the `.claude/` state folder | First time in a project |
| `/start` | Loads context, then you resume, plan a sprint, or just build | Every session |
| `/build` | Executes the work — guardrails, checkpoints, debugging from first principles | After planning, or to iterate |
| `/wrap` | Saves progress, decisions, and learnings so the next session starts smarter | End of session |
| `/roadmap` | Your path to the goal — capture ideas, order what's next (Now / Next / Later) | Anytime priorities shift |

## The loop

1. **`/bootstrap`** once per project — Claude scans your code, asks about your product in your own words, and sets up `.claude/`.
2. **`/start`** → pull something from your roadmap (or plan fresh) → shape a sprint together. The planning effort goes into the *approach* (research-backed, first-principles), not micro-managing steps.
3. **`/build`** → work through it; Claude checks in at the points that matter and trusts itself on the rest.
4. **`/wrap`** → Claude updates your project docs and tees up what's next.
5. Next session, **`/start`** picks up right where you left off.

## What it sets up

Everything lives in a `.claude/` folder at your project root — plain markdown you own and can edit:

```
.claude/
  PROJECT.md       # what this is, who it's for, phase, north star
  ARCHITECTURE.md  # a "Map" on top (stack, services, where things live, patterns), detail below
  ROADMAP.md       # the goal + Now / Next / Later
  DECISIONS.md     # why the project is shaped the way it is — choices + rationale
  PLAYBOOK.md      # what worked well — patterns worth repeating
  sprints/         # current + archived sprints
  research/        # optional pre-sprint research briefs
```

## Install

vibeflow is a set of [Claude Code skills](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/overview). Clone it into your skills directory:

```bash
git clone https://github.com/StephenTownsend1234/vibeflow ~/.claude/skills/vibeflow
```

Each command (`/start`, `/build`, …) is a skill under that folder. Depending on your setup, register each one by symlinking its folder into `~/.claude/skills/` — e.g.:

```bash
for cmd in bootstrap start build wrap roadmap compare-plans; do
  ln -s ~/.claude/skills/vibeflow/$cmd ~/.claude/skills/$cmd
done
```

Then open Claude Code in a project and run `/bootstrap`.

## Philosophy

- **Plan the approach, not the steps.** Spend effort on the expensive-to-reverse decision (the approach); trust Claude to execute the cheap-to-redo work.
- **Get smarter over time.** `/wrap` captures decisions, learnings, and what worked, so context compounds instead of evaporating.
- **You stay in the driver's seat.** One clear decision at a time; nothing written to `.claude/` without your say-so.

## License

MIT — see [LICENSE](LICENSE).
