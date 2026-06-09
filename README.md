# vibeflow

vibeflow is a kit of skills that give Claude the structure to plan collaboratively, build iteratively, and save progress contextually, so every session picks up ready and more informed than the last. Built for vibecoders who use Claude and want momentum across sessions without losing the plot.

## The core commands

| Command | What it does | When |
|---|---|---|
| `/start` | Loads relevant context, then you resume, plan a sprint, or just build | Every session |
| `/build` | Executes the work with guardrails, checkpoints, debugging from first principles | After planning, or to iterate |
| `/wrap` | Saves progress, decisions, and learnings so the next session starts smarter | End of session |

## Sub-commands
| Command | What it does | When |
|---|---|---|
| `/bootstrap` | One-time setup — creates a `.claude/` state folder with templates to store your project context | First time in a project |
| `/roadmap` | Where you capture ideas, order what's next, and shape your path to the goal | Anytime priorities shift |
| `/auto-research` | Async agent that conducts deep research on your roadmap ideas so your next sprint starts faster | Scheduled loop |

## The loop

1. **`/bootstrap`** run once per project — Claude scans your code, asks about your product in your own words, and sets up `.claude/`.
2. **`/start`** → decide what to build together, research the approach, and create a sprint plan you can execute.   
3. **`/build`** → work through it; Claude checks in with you at the points that matter.
4. **`/wrap`** → Claude consolidates your learnings, updates your project docs and tees up what's next.
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

vibeflow is a set of [Claude Code skills](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/overview). Open Claude Code and paste this — it clones vibeflow and registers the commands:

```bash
git clone --depth 1 https://github.com/StephenTownsend1234/vibeflow.git ~/.claude/skills/vibeflow && cd ~/.claude/skills/vibeflow && bash setup
```

That symlinks each command (`/bootstrap`, `/start`, `/build`, `/wrap`, `/roadmap`) into `~/.claude/skills/`. Then open Claude Code in a project and run `/bootstrap`.

### Updating

```bash
bash ~/.claude/skills/vibeflow/update
```

Pulls the latest and re-links any new commands — and `/start` nudges you when your copy is behind.

## Philosophy

- **Plan the approach, not the steps.** Spend effort on the expensive-to-reverse decision (the approach); trust Claude to execute the cheap-to-redo work.
- **Get smarter over time.** `/wrap` captures decisions, learnings, and what worked, so context compounds instead of evaporating.
- **You stay in the driver's seat.** One clear decision at a time; no time wasted building things you didn't mean to. 

## License

MIT — see [LICENSE](LICENSE).
