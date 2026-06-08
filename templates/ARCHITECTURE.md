# Architecture

<!--
Map on top = the cheap, always-loaded orientation layer that /start and the
roadmap investigator read. Detail below = read on demand when working an area.
-->

## Map

**Stack:** <languages, framework(s), database, key libs — one or two lines>

**External services:** <e.g. Stripe (payments), Supabase (auth + DB), Resend (email)>

**Where things live:**
```
<brief file/folder map — the 5-10 directories that matter and what's in them>
```

**Key patterns:** <e.g. server actions for mutations; shadcn components in components/ui; one route file per resource>

## Detail

### Data model
<tables / collections and key relationships, if applicable>

### API / edge functions
<routes and what they do>

### Invariants
<load-bearing rules that must always hold — e.g. "voice in, surfaces out"; "every insight carries a verbatim user quote". Breaking one is a bug, not a choice.>

### Gotchas / learnings
<non-obvious truths about how the system behaves — the "don't do X on this stack" lessons a fresh session would trip on (e.g. "variable fonts ignore fontWeight on iOS RN — needs a static face + native rebuild"). Grows via /wrap. Keep at orientation altitude — the lesson, not the constants.>
