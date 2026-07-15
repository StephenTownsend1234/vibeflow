# How vibeflow works

### A memory and context system for building real products with AI — explained from first principles

*This document doubles as talk material. Each section opens simply, then goes one level deeper for people who want the logic. The system is ~380 lines of plain-language instructions, five markdown files, and one 76-line shell script — no database, no embeddings, no framework.*

---

## The problem: session amnesia

Every AI coding session starts from zero. The model that shipped your feature yesterday remembers nothing today — not the architecture it learned, not the decision you argued about for an hour, not the bug it swore to fix next time. So you re-explain. Every session pays an orientation tax, and the tax *grows* as your project grows.

The standard fixes all disappoint in a specific way:

- **Longer context windows** just delay the amnesia — and a session's hard-won knowledge still dies with the session.
- **Automatic summarization** is lossy exactly where you need precision (which migration is dangerous, which API silently no-ops).
- **Vector-database memory** retrieves *similar* text, not *true* text — and you can't read, audit, or fix what the agent "remembers" about your project.

vibeflow's bet: **the memory system your project needs already exists — files in git.** Readable by you, editable by you, versioned for free, and loaded by any AI tool ever made. The hard part was never storage. It's the questions around storage: *what* gets written, *when*, *where*, by *whom*, and how it stays true. Everything below is an answer to one of those questions.

---

## The architecture: tiered memory, in plain files

Memory-systems research (MemGPT, Letta, Zep) converges on one shape: **tiered memory** — a small always-loaded core, a larger on-demand store, and an archive. vibeflow implements the same shape with markdown:

| Tier | Memory-systems term | vibeflow implementation | Loaded |
|---|---|---|---|
| Always-on core | "core memory" / working context | A shell script (SessionStart hook) injects ~100 lines: project identity, architecture map, roadmap top, sprint status, last session's carry-forward | Every session, automatically, in milliseconds — no AI call |
| Structured long-term | fact/profile memory | Five files: PROJECT (what/who), ARCHITECTURE (how it works + gotchas), ROADMAP (what's next), DECISIONS (why it's shaped this way), sprints (current work) | On demand — a session reads the file its task needs |
| Episodic archive | episodic memory | Archived sprint files — the full story of each piece of work, including failed attempts | Rarely — when history matters |
| Scratch / hypothesis | — | `research/` briefs — disposable pre-work, never canonical | When planning the thing they research |
| User model | profile memory | One global file: working preferences (observed, not asked) + cross-project lessons | Every session |

Two design choices make the tiers work:

**The always-on tier is deterministic.** The hook is shell, not AI: it greps checkbox counts, extracts the Map section, diffs against the last checkpoint. It can't hallucinate, costs nothing, and runs before you've typed a word — so *every* session starts oriented, including the quick-fix session where you'd never invoke any workflow.

**The on-demand tier is lazily loaded.** Sprint files are 10–30KB each; a session reads only the one it's actually resuming, *after* you've picked it. The always-on tier carries just titles and progress counts — the right altitude for choosing. (Memory-systems people call this progressive disclosure; the practical version is "don't read files about work I haven't chosen yet.")

---

## Principle 1 — The repo outranks the files

**Simply:** the project's memory can lie; the project's code cannot. When they disagree, believe the code.

**Deeper:** any written memory drifts — a sprint file says a task is pending when it shipped last night in another chat; a roadmap says "blocked on Apple" when Apple approved last week. Most memory systems treat their store as truth. vibeflow treats every file as a *claim* and git as the *evidence*: before a session briefs you on project state, it checks what actually landed since the last checkpoint, and where file and repo disagree, it says so plainly — "sprint file says X pending; git shows it shipped in `b8f67cf`."

This is proportional, not paranoid: clean tree and nothing committed since the last save → trust the files, skip the check entirely. The verification cost scales with the size of the gap.

The same principle governs the AI's own claims: *before reporting progress, audit each claim against a tool result from this session.* Not "I believe the tests pass" — a test run from this session, or it's reported as unverified.

---

## Principle 2 — Collision by design (adjacency beats archaeology)

**Simply:** organize memory so a new fact physically lands next to the old fact it contradicts.

**Deeper:** the classic memory failure is silent contradiction. You decided X in March; in June you decide not-X; the agent appends the June decision 400 lines below the March one, and future sessions read whichever they stumble on. Git history technically holds the truth — but as one competing agent admitted when we asked it this exact question: *"the git history is an audit trail, not a decision-making tool. I'd just do the replacement."*

You could patch this procedurally: "check git history before overwriting a fact." That's a rule the agent must remember to run, paying a history dig per edit, failing silently whenever it forgets.

vibeflow patches it **structurally**, three ways:

1. **A registry, not a diary.** The decisions file is grouped by *area* (Onboarding, Voice, Auth…), not by date. A new decision about onboarding must be written into the onboarding section — where the old decision already sits, on screen, at write time. The contradiction collides with its predecessor by construction.
2. **Supersede in place.** The old line isn't deleted; it's struck through with a date and a one-line why: `~~use turn count~~ superseded 2026-05-18: turn counts break on short sessions → <<DONE>> marker`. That's *temporal validity* — "what's true now" and "what was true before," with provenance — implemented in markdown strikethrough instead of a temporal graph database.
3. **A size discipline with teeth.** Entries are ≤6 lines; each fact lives in exactly one home; anything shipped gets deleted from the roadmap (its story survives in the archive). Memory that grows unboundedly stops being read — and unread memory is no memory at all.

The general law: **when contradictions collide at write time, you don't need the agent to remember to go looking for them.**

---

## Principle 3 — Transient and timeless never share a file

**Simply:** "we chose Postgres because X" is forever. "The migration isn't deployed yet" is Tuesday.

**Deeper:** the fastest way to rot a knowledge base is writing time-bound states into permanent records — "committed but not yet deployed" inside a decision entry is *guaranteed* to be wrong later, and now something must remember to edit it. So vibeflow routes by half-life: timeless rationale → the decisions registry; current system truth → architecture; **anything that changes outside a session** (deploy pending, review awaited, verification queued) → the sprint's checklist, which is *designed* to be checked off and die. Docs describe what *is*; sprints track what's *in flight*.

---

## Principle 4 — The consent layer: ask what, build how

**Simply:** the AI asks when the answer changes *what* gets built; it acts freely when the answer only changes *how*.

**Deeper:** autonomy fails in both directions. Too little, and you approve every trivial edit (the death-by-checkpoint experience). Too much, and you get code you never asked for (the standard agent experience). The line between them is not "how big is the action" — it's **who the decision belongs to**:

- A fork in what the user will see or live with → one decision card: recommendation, the assumption it rests on, the alternative and when it would win. One decision per turn.
- Everything inside a confirmed direction — file reads, research, subagents, refactors in scope — needs no permission. Internal work is the agent's.
- **Unrequested additions are surfaced, never smuggled.** The single most common way AI sessions go wrong, in our field data, was speculative extras: a "polish layer" nobody asked for caused an entire debugging session. If it's beyond the stated goal, it's a proposal, not an inclusion.
- **A sidestepped answer is not consent.** If the user deflects or says nothing to a real fork, the fork stays open. (Field-tested the hard way: an agent once read "no preference" plus an off-topic reply as approval to lock two architecture decisions.)

This layer is why the memory stays *trustworthy*: nothing enters canon that the human didn't understand entering.

---

## Principle 5 — Research never touches canon

**Simply:** background research writes drafts, never truth.

**Deeper:** vibeflow includes an autonomous background researcher (a scheduled task) that scouts upcoming roadmap items overnight and writes a brief: options, grounding in the actual codebase, known pitfalls. The critical constraint is *where it's allowed to write*: only to the disposable `research/` folder, with a mandatory **"Assumptions I made"** block on top — every question it answered for itself, auditable in ten seconds and correctable in one reply. It cannot touch the architecture, decisions, or roadmap files.

Why so strict? We watched a competing system's research agents return from the web and write findings *directly into canonical memory*, auto-committed. If that research misread a regulation, the project's compliance file is now confidently wrong — in canon, wearing the same authority as human-vetted facts. A wrong vibeflow brief is a throwaway file. **Canon is earned at the moment a human confirms — never before.** The pipeline is: autonomous research → disposable brief → human-confirmed plan → then, and only then, permanent memory.

---

## Principle 6 — Fresh eyes verify

**Simply:** the session that wrote the code shouldn't grade its own homework.

**Deeper:** a model that just built something "knows" it works and reads evidence generously — same as humans. So verification checkpoints split by *who can verify*:

- **Machine-verifiable** (behavior, contracts, data flow) → dispatched to a *fresh-context* verifier: a separate agent that receives only the step's contract and the diff, and actually exercises the change against the running app. It can't rationalize code it never saw being written.
- **Human-only** (visual, feel, on-device) → a concrete action list for the human: "open X, tap Y — does Z happen?" These are the only checkpoints that interrupt.

The plan itself marks each checkpoint `(machine)` or `(human)` at planning time — so autonomy is maximal (machine checks don't stall the run) exactly where human attention is unneeded, and human attention is reserved for what only human eyes can judge.

---

## Principle 7 — Harvest, don't hoard

**Simply:** at session end, one question decides what's remembered: *would a future session act differently knowing this?*

**Deeper:** the end-of-session save (the "wrap") is where the loop closes, and its design fights two failure modes at once:

- **Hoarding.** Most memory systems remember too much — every event, every summary — until the store is unreadably large. The wrap's test is behavioral, not archival: a lesson gets written only if it would *change a future session's behavior*. One-off frictions go unrecorded on purpose: "this is a harvest, not an incident log."
- **The valence trap.** An early version captured only positives ("what worked"), fearing a grievance list. Field data flipped this: the project's most valuable memories turned out to be *failures with their why* — six labeled failed attempts at one UI bug ("do not repeat blindly") saved future sessions from re-walking the same dead ends. Lessons are captured positive or negative; the future-session test, not the mood, is the gate.

The wrap also routes each harvest to its one home (fact → architecture, why → decisions, priority → roadmap, working-style correction → the user profile), re-verifies existing claims in every area the session touched (the anti-rot pass — it has caught stale model versions and a falsely-"DONE" feature claim in production use), and ends with a git checkpoint, so every memory write is one `git diff` from inspectable and one revert from undone.

**The user model is observed, not surveyed.** No onboarding questionnaire. The profile fills from *revealed* preference — moments the user corrected how the AI worked — which beats stated preference every time.

---

## Principle 8 — Experience before tech

**Simply:** for anything a user will touch, design the felt experience before researching the architecture.

**Deeper:** technical forks masquerade as the important decisions, but experience forks usually *decide* them. Real example: a notification feature's capture mechanism (server-side extraction vs. live in-chat confirmation) looked like a pure architecture choice — until walking the experience ("what happens when the AI mishears 9am for 9pm?") showed the confirmation moment was load-bearing, which eliminated the extraction option entirely. So planning walks the moments first — first contact, the happy path, the failure moment, what it says and in whose voice — and only then researches how. "Build things people want" is a planning *step*, not a poster.

---

## Principle 9 — Silent ≠ invisible

**Simply:** don't narrate operations; don't disappear either.

**Deeper:** two symmetrical communication failures. Narrating every file read ("Let me check… now reading… okay, I see…") wastes the human's attention. But six silent minutes of unexplained work — a real field incident — destroys trust just as fast. The rule pair: work silently and narrate only decisions, tradeoffs, and findings; **and** before any long autonomous stretch, one scoping line — "re-grounding task B; its citations predate 15 commits" — then quiet.

---

## The loop, end to end

```
bootstrap (once)   scan the repo, capture the vision, map the path,
                   install the orientation hook
      │
   start ──────►   oriented in milliseconds (hook) → route: resume /
                   plan / just build → planning = gather the human's
                   context → research → decide → one approval gate
      │
   build ──────►   one-shot by default after a good plan; machine
                   checkpoints self-verify; guardrails on scope
      │
   wrap ───────►   reconcile against the real diff → harvest (future-
                   session test) → route to one home each → re-verify
                   touched claims → checkpoint commit
      │
      └────────►   next session starts smarter — the tax became an asset
```

Evidence from ~3 months on a real product (a React Native health app, solo founder):

- **Mistakes stopped repeating.** A database-wipe incident became a gotcha + a hook guard; every later session obeyed it cold. Six failed attempts at a text-scaling bug were recorded with their whys; the eventual fix cited them.
- **Research compounds.** Overnight briefs were consumed at a 100% rate (zero orphaned research) and one killed a week of over-scoped work before it started ("you do NOT need a Services ID").
- **The memory self-corrects.** The anti-rot pass caught stale architecture claims the same week they went stale, and corrected a "feature DONE" claim that field testing proved false.
- **The docs stayed readable.** Decision registry entries ≤6 lines, roadmap top ≤40 lines, orientation ≤100 lines — after three months of daily use.

---

## What vibeflow deliberately does NOT have

Honest scoping is part of the design. Compared to the memory-systems landscape:

- **No vector database / semantic retrieval.** At single-project scale the corpus is kilobytes; grep over files you named yourself has zero retrieval-failure modes. Vector recall earns its place at team scale or across dozens of projects — not before.
- **No temporal knowledge graph.** Dated supersede-markers deliver "what's true now vs. before, with provenance" at this scale. A graph database is the enterprise version of a strikethrough.
- **No automatic memory writes mid-conversation.** Everything enters canon through the wrap's human-confirmed gate. Slower by one confirmation; trustworthy forever.
- **No agent-initiated structure.** The AI never invents new memory files on its own — domain files (a DESIGN.md, a compliance doc) work when the human creates them and rot when the agent does.
- **No always-on autonomy.** Background work is opt-in, bounded (one brief per run, quiet runs are fine), and writes only to the disposable tier.

Every one of these is a *scale* decision, not a philosophical one — the doc that changes them is one honest sentence about when: teams, multi-project corpora, server-originated workflows.

---

## The one-slide takeaway

> **Memory isn't a database problem — it's an editorial problem.**
> Store memory as plain files in git. Inject a deterministic core every session. Treat files as claims and the repo as truth. Organize so contradictions collide at write time. Keep transient state out of permanent records. Let research draft but never publish. Make a human the gate to canon — and at every session's end, keep only what would change a future session's behavior.

Built by a vibecoder and an AI, iterating on the system *with* the system — every principle above traces to a specific session where its absence hurt.
