# gbrain learnings — 2026-07-29

Source: deep read of https://github.com/garrytan/gbrain (Garry Tan's open-sourced personal
knowledge system; clone inspected at README, DESIGN, ethos essays, skills/RESOLVER.md,
signal-detector + maintain skills, executive-assistant + brain-vs-memory guides,
INSTALL_FOR_AGENTS.md). Session: exploratory analysis with Stephen, no build.

## What gbrain is (four ideas)

1. **Markdown git repo = system of record; Postgres = disposable index.** Hybrid retrieval
   (vector + BM25 + RRF + reranker) plus a knowledge graph auto-built from `[[wikilinks]]`
   with zero LLM calls (their benchmark: graph adds ~+31 pts P@5 over vector-only).
2. **Ambient capture on every message** (signal-detector skill, silent parallel sub-agent):
   original thinking in the user's exact phrasing + entity pages with mandatory backlinks
   ("an unlinked mention is a broken brain"), citations on every fact, notability gate
   against bloat.
3. **Brain-first lookup; answer-not-pages.** `gbrain think` returns a synthesized, cited
   answer **plus gap analysis** — what the brain doesn't know / how stale its sources are.
4. **Overnight "dream cycle"** (8-phase cron): lint → backlinks → sync → synthesize →
   extract → patterns → embed → orphans. Dedup, citation fixing, contradiction detection
   while the user sleeps.

The disciplines are the product; the engine is replaceable.

## vibeflow comparison

Independently converged on the same doctrine: thin harness / fat skills, routing by skill
description, one-home-per-fact (their brain/memory/session split ≈ our routing rules),
progressive disclosure, files over DBs, deterministic orientation. Garry's 20K-line
CLAUDE.md that degraded attention and got cut to ~200 lines of pointers = our CLAUDE.md
demotion pass. Difference is scope: vibeflow = per-project *building* memory; gbrain =
cross-project *world/life* memory. Complementary layers. `playbook.md` is the embryo of
the second layer (curated, not accumulated).

## Adopted 2026-07-29 (Stephen approved)

- **Ask-twice rule** → CORE guiding principle "Recurring work gets codified, not repeated"
  + wrap's **automation ticker**: `.claude/automations.md`, one line + date per manual task
  spotted at wrap; 2+ dates → wrap proposes automate-or-delete.
- **Friction/delight capture (super simple)** → wrap appends max one line per session to
  `~/.claude/vibeflow/friction.md`, only for moments the user would recognize. Feeds pack
  fixes (incl. brother's cold-start friction) without Stephen mediating.

## Parked (deliberately not adopted yet)

- **Gap analysis in /start research + briefs** ("answer + what I don't know + staleness") —
  Stephen unsure it adds over sprint planning's existing unknown-unknown hunting. Revisit if
  research briefs ever feel overconfident.
- **Dream-cycle job ideas for the background routine** (autonomy wave): re-verify
  ARCHITECTURE `path:line` claims against code; flag DECISIONS entries contradicted by
  recent commits; pre-research the next roadmap item. gbrain proves the overnight
  consolidation pattern at production scale.
- **skillopt precedent** for the eval-loop roadmap item: treat SKILL.md as a trainable
  parameter, benchmark, keep only edits that score higher (`docs/guides/skillopt.md`,
  `docs/tutorials/improving-skills-with-skillopt.md`).
- **Latent vs deterministic** as a stated CORE principle ("lookup table → code; judgment →
  skill") — already lived via the hook; add prose only if a real confusion shows up.

## Personal brain (Stephen's direction)

Lean: personal context about life and work — emails, people, ideas, projects, health,
finances. Key findings:
- **Capture is the bottleneck, not retrieval.** Garry's brain works because everything
  flows in automatically (Telegram agent, meeting/email/tweet ingestion). A manually-fed
  brain dies in weeks. Design question #1: which sources (Gmail, messages, notes, bank
  feeds) can flow in without effort, and which would Stephen let an agent read?
- **Finances/bookkeeping ≠ brain pages** — mostly deterministic pipelines (fetch,
  categorize, reconcile, remind) with a thin judgment layer. Separate automation target.
- **Trial before build**: local gbrain (installed 2026-07-29, see `~/brain/GBRAIN-TRIAL.md`)
  to learn what a brain feels like + which capture habits stick. Full autonomous setup
  (daemon, cron, embedding keys) is a real ops commitment — earn into it.

## Jumbo long-covid knowledge base (separate Jumbo project — capture on Jumbo's roadmap)

gbrain's shape fits it almost perfectly: drop in a study → typed extraction (`paper`,
`symptom`, `treatment`, `trial` via schema packs), citation graph, contradiction detection,
gap analysis over the literature ("no studies on X since 2024"). Open forks when planned:
curator-facing (Stephen drops in studies) vs patient-facing; own infra (Jumbo's Supabase +
pgvector) vs gbrain as the curation tool. Not a vibeflow item.
