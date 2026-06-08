# Sprint sequencing

When the user's dump contains two or more items that, shipped independently, would each be worth running as their own sprint, **split by default**. Don't bundle and wait for pushback.

## Lineup format

```
Sprint lineup (proposed):

1. <Sprint name> — <one-sentence goal>
   Carries: <items from dump>
   Tag: <simple | standard | unknowns | blocked>
   Depends on: <prior sprint, or "nothing">

2. <Sprint name> — <one-sentence goal>
   Carries: <items>
   Tag: <complexity>
   Depends on: <prior sprint or "nothing">

(...)

Sprint 1 is what we plan in detail today. Confirm the lineup and the Sprint 1 cut, or reshuffle.
```

## Sequencing rules

- **One goal per sprint.** If two items don't serve a single goal, they belong in different sprints.
- **A user-stated deadline (if any) lives on Sprint 1 only.** It caps Sprint 1's scope; it does not size the lineup as a whole.
- **Items that depend on real-user feedback go after the sprint that ships to users**, not before. You can't iterate on feedback you don't have.
- **Polish folds into the sprint that introduces the thing being polished**, not into a "polish sprint" of its own — unless the polish itself is what unlocks the user.
- **If the user named a deadline, ruthlessly cut Sprint 1 to the smallest functional slice that ships before it.** Move everything else into later sprints in the lineup. Don't stuff Sprint 1 to fill the calendar.

## After the lineup is confirmed

Only Sprint 1 goes through Stage 2.3 → Pre-Plan Handshake → plan mode. The rest live as proposed candidates the user can return to via a later `/start`.

If the user wants the lineup written into ROADMAP.md as proposed-next-sprints, offer to do that. Don't do it unprompted.
