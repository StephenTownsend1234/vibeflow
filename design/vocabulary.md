# Vocabulary

Evaluative words in the left column. Observable descriptions in the right. The right column is what a model can render and an engineer can build.

---

## Part 1: Evaluative to observable

These are the words most often reached for, and what they usually mean underneath. Pick the row that matches the intent, then use the right column.

| Word | What it fails to specify | Say instead (images) | Say instead (UI) |
|---|---|---|---|
| Clean | Nothing physical | Off-white background, one accent colour, generous margins, no texture, no props | One type family, two weights, 8px spacing scale, no borders, whitespace does the grouping |
| Calm | Nothing physical | Soft diffuse light from one side, muted desaturated palette, no hard shadows, low contrast | Low contrast between surfaces, slow transitions (300ms+), large radius, no red, no motion on load |
| Warm | Colour or emotion, unclear which | Warm grade, cream and sage tones, low contrast, golden ambient light | Cream or sand background instead of white, serif headings, rounded corners, off-black text |
| Modern | Drifts by decade | Flat vector illustration, uniform thin stroke weight, no gradients, no drop shadows | Tight tracking on headings, high type-size contrast, generous line height, minimal chrome |
| Premium | Nothing physical | Shallow depth of field, single hard light source, deep shadow falloff, restrained palette | More whitespace than feels necessary, one accent used sparingly, no borders, subtle elevation only |
| Professional | Nothing physical | Even studio lighting, neutral seamless backdrop, sharp throughout, no ambient clutter | Consistent alignment grid, no decorative elements, dense but well-spaced tables, muted palette |
| Playful | Nothing physical | Saturated flat colours, hand-drawn line quality, off-grid composition, visible texture | Larger radius, bouncy easing, illustration in empty states, colour used generously |
| Editorial | Nothing physical | Collage or mixed media, cropped photography, generous margin, one bold typographic element | Serif display face, wide measure, pull quotes, asymmetric layout, hairline rules |
| Trustworthy | Nothing physical | Real photography, natural skin texture, eye-level framing, no stylisation | Visible authorship, plain language, predictable layout, no dark patterns, clear affordances |
| Minimal | How minimal | Single subject, empty background, one light source, no props, wide negative space | One column, three levels of hierarchy maximum, no icons unless load-bearing |
| Dense | Nothing physical | Full frame, overlapping elements, layered composition, no empty areas | 4px spacing scale, smaller type, table over cards, all data visible without expansion |

---

## Part 2: Image vocabulary

### Medium (decide this first, it constrains everything else)

Photograph · flat vector illustration · editorial collage · mixed media · risograph print · screenprint · watercolour · gouache · pencil sketch · marker sketch · line art · isometric illustration · technical blueprint · 3D render · claymation render · halftone print · woodcut · infographic · diagram

Naming the medium removes more ambiguity than any adjective. "Editorial collage" and "flat vector illustration" produce entirely different images from the same subject.

### Framing and camera

| Term | What it does |
|---|---|
| Eye-level | Neutral, human, relatable |
| Low angle looking up | Makes the subject tall, substantial, imposing |
| High angle looking down | Makes the subject small, vulnerable, or surveyable |
| Overhead / flat-lay | Removes depth, good for arrangements and products |
| Three-quarter | Shows two faces of an object, the default product hero |
| Macro | Extreme close detail, texture becomes the subject |
| Wide establishing | Subject small in context, the environment matters |
| Close-up | Face or detail fills the frame, emotional |
| Centred symmetrical | Formal, still, deliberate |
| Off-centre | Dynamic, has room to breathe on one side |

### Lens behaviour

- **50mm, shallow focus** — natural human perspective, background falls away
- **85mm at f/8** — subject fully sharp front to back, background softly blurred (product default)
- **24mm wide** — expansive, slight edge distortion, environmental
- **Macro** — one plane sharp, everything else gone

### Lighting

| Term | Effect |
|---|---|
| Soft overcast daylight | Even, gentle, no drama, forgiving |
| Single hard source from camera left | Strong directional shadows, sculptural, dramatic |
| Large softbox from the left with a reflector right | Controlled commercial product lighting |
| Backlit / rim light | Glowing outline, separates subject from background |
| Golden hour | Long warm shadows, low sun |
| Even studio lighting | Flat, informational, no mood |
| Deep falloff into shadow | High contrast, most of the frame dark |
| North-facing window light | Cool, soft, indirect, domestic |

### Colour treatment

Desaturated · muted earth tones · two-colour overprint · teal-and-amber grade · monochrome with one accent · cool cast in the shadows · warm neutral · high-key (bright, low contrast) · low-key (dark, high contrast) · limited palette of three colours · pastel · saturated flat colour

Pin a style word to a colour fact. "Cinematic" drifts. "Teal-and-amber grade with hard shadows" does not.

### Texture and finish

Paper grain · film grain · visible halftone dots · slightly misregistered ink · torn paper edges · matte finish · glossy with specular highlights · translucent glassy · brushed metal · condensation droplets · chipped paint · worn edges

Texture is what separates a real-looking image from an obviously generated one. Name at least one physical imperfection.

### Constraints (state what to exclude)

no text · no hands · no people · no visible logos · no horizon · no props · no harsh specular hotspots · no gradients · no drop shadows · no lens flare

---

## Part 3: UI vocabulary

### The five hierarchy levers

Every hierarchy problem is solved with some combination of these. Naming which one is being used prevents reaching for all five at once, which is what makes interfaces noisy.

1. **Size** — bigger reads first
2. **Weight** — bolder reads first
3. **Colour** — higher contrast reads first
4. **Position** — top-left reads first in left-to-right languages
5. **Space** — isolation reads first

Rule of thumb: use two levers per level of hierarchy. Three or more and it starts shouting.

### Spacing

- **Scale** — pick 4px or 8px and use multiples only. 4, 8, 12, 16, 24, 32, 48, 64. Arbitrary values are the single most common tell of an untrained layout.
- **Proximity** — related things sit closer to each other than to unrelated things. Grouping is done with space before it is done with borders or cards.
- **Density** — how much fits per screen. High density suits expert tools and data. Low density suits emotional, first-time, or impaired-attention contexts.
- **Vertical rhythm** — consistent gaps between sections so scrolling feels regular.

### Type

- **Scale** — a ratio between sizes, typically 1.2 (subtle) to 1.5 (dramatic). Consistency matters more than the exact ratio.
- **Measure** — line length. 45 to 75 characters for body text. Wider is tiring to read.
- **Line height** — 1.4 to 1.6 for body, 1.1 to 1.25 for large headings.
- **Weight contrast** — two weights is usually enough. Regular and semibold, or regular and bold.
- **Tracking** — tighten large headings slightly (-0.02em), loosen small caps and labels (+0.05em).

### Depth and surface

Three ways to separate one surface from another, in increasing loudness:

1. **Background shift** — quietest, a slightly different tint
2. **Hairline border** — precise, structural, works at high density
3. **Shadow / elevation** — loudest, implies the surface can move or is temporary

Pick one per context. Combining a border and a shadow on the same card is usually a sign of indecision.

### Shape

- **Radius** — 0 (technical, precise), 4 to 8 (neutral, modern), 12 to 20 (soft, approachable), full-round (playful, pill).
- **Stroke weight for icons** — 1.5 to 2px. Consistency across the icon set matters more than the value.

Radius carries a lot of emotional meaning for very little effort. It is the fastest lever for changing feel.

### Motion

| Duration | Feels like |
|---|---|
| 100 to 150ms | Instant, mechanical, for hover and small state changes |
| 200 to 300ms | Noticed but not waited for, the default for most transitions |
| 350 to 500ms | Deliberate, ceremonial, for entrances and page transitions |
| Over 500ms | Slow, and users will wait through it twice before it becomes annoying |

Easing: `ease-out` for things entering (fast start, gentle landing). `ease-in` for things leaving. `ease-in-out` for things moving within the screen. Linear only for continuous things like spinners.

Animate `transform` and `opacity`. Animating width, height, or position causes jank.

### "Feel" mapped to parameters

| Feel | Radius | Motion | Contrast | Density |
|---|---|---|---|---|
| Calm, restful | 12 to 20 | 300ms+, ease-out | Low | Low |
| Precise, technical | 0 to 4 | 120ms | High | High |
| Approachable, warm | 12 to 16 | 250ms | Medium | Low |
| Premium, restrained | 4 to 8 | 300ms | Medium, one accent | Low |
| Energetic | 8 to full | 200ms with slight overshoot | High, saturated | Medium |
