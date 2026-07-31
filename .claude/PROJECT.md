# Project: vibeflow

**What it is:** Stephen's memory + workflow system for building real products with AI — five skills (`/bootstrap` `/start` `/build` `/wrap` `/roadmap`), a shared CORE.md, five per-project state files, and a deterministic SessionStart hook. Every session picks up more informed than the last. Built and tuned *with itself*: the primary test project is Jumbo (long-covid companion, `~/long-covid-companion/jumbo`).

**Who it's for:** Stephen first; his brother (legal platform, first external user) next; vibecoder community eventually.

**Phase:** v3 built + field-tuned (July 2026), and **shipped on `main`** — merged 2026-07-31, so a plain clone of GitHub `StephenTownsend1234/vibeflow` installs v3. Development happens on main directly; the pre-v3 tree survives as tag `v2`. Live locally via symlinks. Now: dogfooding, distribution, and the autonomy wave.

**North star:** compounding knowledge without bloat, autonomy without lost trust — the human understands every line that governs them.

**How this project is iterated (the meta-process that got us here):**
- Dogfood on Jumbo → Stephen flags friction precisely (with the exact moment) → diagnose from first principles → smallest fix that encodes the lesson → commit with the why. Twelve+ field fixes landed this way; every rule in the pack traces to a session where its absence hurt.
- **Propose before applying.** Inspired-but-unrequested changes to the pack are decisions Stephen must understand first — this rule itself came from a correction (2026-07-02, run-skill-generator wiring applied without asking).
- Evidence beats taste: claims about what works cite a transcript, a Jumbo file, or the Fable 5 docs. Fresh-context critics review big rewrites (the Claude-A/Claude-B loop).
- Tuning heuristic: anything that happens *before the user has expressed intent* must be near-instant (hook-fed); anything slow must happen *after* a choice, in service of it.

**Key references (read on demand):** `docs/v2-vs-v3-crosswalk.md` (every v2 mechanism → what happened + why, plus open flags) · `docs/how-vibeflow-works.md` (principles, talk/landing material) · auto-memory `vibeflow-v3-redesign-direction.md` in Stephen's home-project memory · git log (every commit message carries its rationale).
