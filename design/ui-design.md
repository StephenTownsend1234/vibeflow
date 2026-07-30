# UI Design for Coding Work

For any session where an interface is being built. The aim is to make design decisions explicit and named, so they can be argued with, rather than absorbed silently into the code.

The public `frontend-design` skill covers aesthetic direction: palette, typeface pairing, avoiding templated looks. This file covers the layer underneath: what is being built, which component, which states, and how the flow holds together. Use both.

---

## Before writing any UI code

Answer these five. If they cannot be answered, the design decision is being made by accident.

1. **What is this screen's single job?** One sentence. If it needs "and", it may be two screens.
2. **What does the user know when they arrive, and what do they carry away?** This defines what must be on screen and what is redundant.
3. **What is the primary action?** Exactly one per screen. Everything else is secondary or tertiary and should look it.
4. **What is the worst state?** Empty, error, or overloaded. Design it now, because it will be the most common state early on.
5. **What is the constraint?** Small screen, cognitive load, one hand, low light, slow connection, accessibility need. Constraints produce better designs than taste does.

State the answers before coding. Two sentences is enough.

---

## What are we actually designing? The four levels

Confusion in UI conversations usually comes from mixing these levels. Name the level first.

| Level | Question it answers | Example |
|---|---|---|
| **Flow** | What sequence of screens, and what decision is made at each? | Onboarding: welcome → permission → first conversation → home |
| **Screen** | What is the job of this one view, and how is it divided? | Home: summary, input, two surfaces |
| **Component** | Which pattern presents this piece of content or action? | The summary is a card, not a banner |
| **State** | What does this look like when empty, loading, or broken? | Home before any conversation has happened |

Most design mistakes are level errors: solving a flow problem by restyling a component, or solving a component problem by adding a screen.

---

## Component decisions

The options, and what each one signals. Choosing the wrong one is more damaging than styling it imperfectly.

### Showing more detail

| Pattern | Use when | Signals |
|---|---|---|
| Inline expand | The detail belongs to the item and the user stays in context | "This is more of the same thing" |
| Accordion | Several peer items, one open at a time, scanning is the goal | "Pick which one you care about" |
| Modal / dialog | A decision must be made before continuing | "Stop and deal with this" |
| Bottom sheet / drawer | Secondary detail on mobile, dismissible, context stays visible behind | "Here is more, you can go back" |
| New page | The detail is substantial and shareable, or has its own sub-actions | "This is its own thing" |
| Tooltip / popover | A short clarification, not essential to the task | "In case you were wondering" |

Modals are overused. A modal interrupts. If the user is not required to respond, it should not be a modal.

### Choosing between options

| Pattern | Use when |
|---|---|
| Radio group | 2 to 5 options, all worth reading, one choice |
| Segmented control | 2 to 4 short options, switching is cheap and reversible |
| Dropdown / select | 6+ options, or the list is long and familiar |
| Tabs | Switching between peer views of the same subject |
| Chips / multi-select | Several can be true at once, options are short |
| Toggle / switch | Binary, takes effect immediately, no save step |
| Checkbox | Binary, part of a form, takes effect on submit |

A toggle that requires a save button is a lie. Use a checkbox.

### Feedback

| Pattern | Use when |
|---|---|
| Inline validation | The problem is with a specific field. Put it next to the field |
| Toast / snackbar | Something succeeded, non-blocking, disappears |
| Banner | Persistent condition affecting the whole screen (offline, trial expiring) |
| Empty state | No data yet. This is an invitation, not an apology |
| Skeleton | Loading, and the shape of the result is known |
| Spinner | Loading, and the shape is unknown, or under 1 second |
| Progress bar | Loading with a knowable duration |

Errors should say what happened and what to do about it. They do not apologise and they are never vague.

### Structuring lists of things

| Pattern | Use when |
|---|---|
| Table | Comparing across attributes, scanning columns, expert users |
| List rows | Sequential, one primary attribute per item, mobile |
| Cards | Each item is visually distinct or has an image, browsing not comparing |
| Grid | Visual items where the image is the content |

Cards are the default reach and are often wrong. If the user is comparing values, they need a table.

---

## States to design

Every list, every fetch, every form. Skipping these is the most common gap between a demo and a product.

- **Empty** — no data yet, first-run. Say what will appear here and how to make it appear.
- **Loading** — first load, and refreshing while data is already shown (different treatments).
- **Partial** — some data arrived, some failed.
- **Error** — what happened, what to do, a way to retry.
- **Offline** — if the product works without connection, say so; if not, say that.
- **Success** — after the primary action. Where does the user go next?
- **Overloaded** — 500 items instead of 5. Does it paginate, virtualise, or collapse?
- **Overflow** — a name that is 90 characters. Truncate, wrap, or scale?
- **Permission denied** — the user cannot see or do this. Say why.

For most products, the empty state is what a new user sees first and is the most important screen in the product.

---

## Flow

A flow is a sequence of decisions, not a sequence of screens. Describe it as decisions:

```
Entry → what brought them here, what they already know
Step 1 → the decision made here, what it costs them
Step 2 → the decision made here, what it costs them
Exit  → what they have, where they land, what happens next
```

Questions worth asking about any flow:

- **Can a step be removed?** The fastest improvement to any flow is deleting a screen.
- **Can a decision be deferred?** Asking for something before it is needed is the main cause of abandonment.
- **Is anything asked twice?** Including things asked implicitly.
- **What happens on interruption?** Phone call, closed tab, dead battery. Is progress kept?
- **What is the back button doing?** Reversing one step, or losing everything?
- **Where does the flow branch?** Every branch doubles the states to design. Justify each one.

---

## Feel

"Feel" is not vague. It resolves to five measurable parameters. When a request comes in for a certain feel, set these explicitly.

| Parameter | Range | What it controls |
|---|---|---|
| **Density** | 4px scale (tight) to 8px+ (open) | How much fits per screen, how urgent it feels |
| **Contrast** | Surface-to-surface and text-to-background | How loud, how legible, how much it demands attention |
| **Radius** | 0 to full-round | Precision versus approachability. The cheapest lever |
| **Motion** | 120ms to 400ms, plus easing | Mechanical versus considered |
| **Copy** | Terse to conversational | More than half the perceived personality |

Copy is underrated as a design material. The same layout with "Submit" versus "Save changes" versus "Got it, save this" reads as three different products.

See `vocabulary.md` for the mapping from named feelings to these parameter values.

---

## Accessibility floor

Not optional and cheap to do from the start.

- Text contrast at least 4.5:1 for body, 3:1 for large text
- Tap targets 44x44px minimum
- Visible keyboard focus states, never `outline: none` without a replacement
- `prefers-reduced-motion` respected
- Colour never the only carrier of meaning
- Form inputs have real labels, not only placeholders
- Real heading hierarchy, not styled divs

---

## Worked example (a health app whose users have brain fog)

The pattern applied to a real brief, showing how constraints produce the design.

**Constraint:** users have brain fog and low energy. Cognitive load is the binding constraint, ahead of feature completeness.

**Decisions that follow:**
- Maximum two content surfaces on the home screen. The constraint is the feature.
- Voice as primary input, because typing costs energy.
- Surfaces are output, not input. No forms inside them.
- Data visualisation as smooth trend lines, because jagged graphs read as alarming.
- Gentle progress indicators over leaderboards or streaks, because failure states in gamified products punish the sick.
- Large radius, low contrast between surfaces, 300ms+ transitions, generous spacing. Feel target: calm, restful.
- Copy register: a knowledgeable friend, not a doctor, therapist, or coach.

**What this illustrates:** every visual decision traces back to a named constraint. That is what makes it defensible rather than a matter of taste.
