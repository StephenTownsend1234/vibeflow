# vibeflow

vibeflow is a kit of skills that give Claude the structure to plan collaboratively, build autonomously, and save progress contextually, so every session picks up ready and more informed than the last. Under the commands is a memory system: plain markdown files in your project that Claude reads on session start and maintains on session end — your vision, your architecture, your decisions and their whys — so context compounds across sessions instead of evaporating with each chat.

## New here? Two commands.

You only need to remember two: **`/start`** when you sit down, **`/wrap`** when you're done. Everything else happens in flow — setup is offered the first time you `/start` a project, building begins automatically once a plan is agreed, and saying things like "add X to the roadmap" or "let's wrap up" just works without slash commands.

## The commands

| Command | What it does |
|---|---|
| `/start` | Orients and routes your session — your project state is already loaded by a session-start hook, so you go straight to choosing the work: resume the sprint in flight, plan a new one (sharpen the intent → research the approach → decide it together → plan the steps), or build freely without a plan |
| `/build` | Executes the work autonomously within the plan you agreed — runs straight through by default (one-shot), verifies its own claims against real tool output instead of memory, holds scope, and only interrupts you where a decision genuinely changes what gets built |
| `/wrap` | Saves the session into a compounding, accurate knowledge base — reconciles what the plan claims against what git shows actually shipped, routes each new fact to its one home (architecture, decisions, roadmap, lessons), rewrites claims the session made stale, and commits a checkpoint |
| `/roadmap` | Keeps the path to your goal — capture an idea in one line the moment you have it, or run a real session that orders everything into Now / Next / Later toward a concrete goal |
| `/bootstrap` | Sets a project up, once — scans the code for the architecture, asks you for the vision only you can give, maps the first roadmap, and writes the `.claude/` files everything else runs on |

## The loop

1. **`/bootstrap`** once per project — vision captured, path mapped, memory files created.
2. **`/start`** → pick up exactly where you left off and decide what to build.
3. **`/build`** → Claude works through it, checking in at the moments that matter.
4. **`/wrap`** → progress, decisions, and lessons get written down and committed.
5. Next session, **`/start`** opens already knowing all of it.

## What Claude remembers

Everything lives in a `.claude/` folder at your project root — plain markdown you own and can edit:

```
.claude/
  PROJECT.md       # what this is, who it's for, phase, north star
  ARCHITECTURE.md  # how it's built — a Map for orientation on top, detail and gotchas below
  ROADMAP.md       # the goal and the path: Now / Next / Later
  DECISIONS.md     # why the project is shaped the way it is — choices + rationale
  sprints/         # the work: current sprints + an archive of finished ones
  research/        # approach research, often done ahead of time in the background
```

A session-start hook feeds the essentials into every new session automatically, so Claude is briefed before you've typed a word. And one profile lives outside any project — `~/.claude/vibeflow/playbook.md` — where your working preferences and cross-project lessons accumulate, learned from the corrections you give rather than a questionnaire.

## Background routines (opt-in)

Switch these on and vibeflow works between sessions, on a daily schedule:

- **Ship Captain** — checks your progress against your goal and flags drift.
- **Ship Spotter** — researches upcoming roadmap items ahead of time and writes briefs, with its assumptions listed on top so you can correct them in one reply. By the time you plan, the homework's done.

Everything works without them.

## Install

vibeflow is a set of [Claude Code skills](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/overview). Open Claude Code and paste this — it clones vibeflow and registers the commands:

```bash
git clone --depth 1 https://github.com/StephenTownsend1234/vibeflow.git ~/.claude/skills/vibeflow && cd ~/.claude/skills/vibeflow && bash setup
```

Then open Claude Code in a project and run `/bootstrap`.

### Updating

```bash
bash ~/.claude/skills/vibeflow/update
```

Pulls the latest and re-links any new commands — vibeflow checks once a week and nudges you in-session when your copy is behind.

## Philosophy

- **Plan the approach, not the steps.** Spend effort on the expensive-to-reverse decision (the approach); trust Claude to execute the cheap-to-redo work.
- **Get smarter over time.** `/wrap` captures decisions, learnings, and what worked, so context compounds instead of evaporating.
- **You stay in the driver's seat.** Claude asks when the answer changes *what* gets built, and builds autonomously when it only changes *how* — one clear decision at a time, always with a recommendation.

## License

MIT — see [LICENSE](LICENSE).
