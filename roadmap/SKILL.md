---
name: roadmap
description: The project's path to its goal — capture ideas onto the roadmap, or run a session that orders everything into Now/Next/Later toward a concrete goal. Use for "add to roadmap X" quick captures, when priorities shift, when the user asks what to build next, or when the goal itself needs resetting. Also runs inside /bootstrap to map the initial path.
---

# /roadmap

Read `~/.claude/skills/vibeflow/CORE.md` (or `CORE.md` at the vibeflow pack root, wherever it's installed) first. 

Mode stance: **Strategist. Work out the path to the goal — what to build next and in what order — and pressure-test it.**

The roadmap answers one question: what do I build next to reach my goal? It's light and living. ROADMAP.md is two-tier (template: `../templates/ROADMAP.md`): **top = the path in strict one-liners** (all `/start` and the hook ever read), **Details below the fold** = each item's fuller context, keyed by slug (what Ship Spotter researches from).

## Mode 1: Quick capture

For when the user asks to add something to roadmap for future work. Detect "Add to roadmap X" — append with zero ceremony, in any mode: one-liner in the right tier (default Later unless it's clearly next), full context into its Details block exactly as given — don't trim, richness is what makes later research good. One move, back to what they were doing. This is also where `/build`'s deferred discoveries and `/wrap`'s deferred TO-DOs land.

If the item is large, uncertain, or unfamiliar tech, offer in one line to queue a background micro-brief (a subagent writing `research/<slug>.md` while you keep working) — skippable, never automatic for small items.

## Mode 2: Work the roadmap

For when a user wants to orient their work on the project. Judge the altitude the session needs — a quick re-order takes a minute; "help me figure out what's next" may need a real session; a genuine pivot revisits the vision. Orient silently from what's loaded plus the sprint archive (what's shipped is reflection fuel: "you've shipped X and Y — does that change the goal?"). Assume the user doesn't have the roadmap file open — when discussing items, list them out (titles, or the relevant one-liners) rather than referring to them by position or slug alone.

**Explore.** The context that improves a project lives in the user's head, not the code. Invite the whole picture — what would make it great, what they're avoiding — and play it back before structuring. Keep it conversational. Play it back: "Here's what I'm hearing you're building toward". 

**Set the goal.** Near-term and concrete ("a usable v1 I can show people"), not an abstract milestone. Push gently if vague: "launch what, to whom — what's true when it's done?" Plan the near, rough the far.

**Order the path** by what unlocks the goal soonest (value × dependency). The sanity checks that earn their keep:

- Is this really three things? Split bundles.
- What unlocks what — anything out of dependency order?
- What are you avoiding? The unsaid thing is often the dreaded one — name it.
- The one thing: "if you could ship only one thing in two weeks, which?" → top of Now. No ties.

Consider the route, not just the order — validate before building, thin slice end-to-end, riskiest first. (The technical *how* is `/start`'s job.)

**Hygiene while you're in the file:** delete shipped items (top line + Details block), fix dead pointers, keep Done capped (~10 lines), keep the top tier skimmable — one-liners only, context lives in Details.

**Hand off.** The top of Now is the next sprint candidate — offer to flow into `/start` for it (note if a brief already exists). Apply the updated ROADMAP; record a genuine strategic shift (dropped goal, changed phase) in DECISIONS.

## Background routine (opt-in)

Ship Captain (progress vs goal) + Ship Spotter (researches upcoming items ahead of time, autonomously) run as a daily local routine — see [references/background-routine.md](references/background-routine.md). Offer setup via `/schedule` at the end of the first real roadmap session; recommend daily.

## Called from /bootstrap

The vision is already in hand — don't re-ask it. Go straight to problem space → goal → Now/Next/Later, don't write to disk, and hand back cleanly: "Roadmap done — here's the goal and the path" with the Goal + tiers for bootstrap to fold in. Bootstrap offers the background routine, not you.
