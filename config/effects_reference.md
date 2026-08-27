# Effects reference

Purpose and intent behind each lighting effect — why it exists, what
problem it solves, and when to reach for it over a neighboring effect. This
is a design reference for implementing or choosing between effects, not a
parameter schema.

Effects split into two families that never overlap in what they control:
**intensity-domain** effects (light on/off/color) and **position-domain**
effects (where a moving fixture points). This split is what lets a
positioning effect and a brightness effect run on the same fixture at the
same time without conflict — one is aiming the fixture, the other is
deciding how bright it is once aimed. Every effect below exists to serve
one of these two concerns, never both.

---

## Intensity-domain effects

These answer "how bright, and what color, right now" — never "where."

### `full`

The baseline look: a light held at a constant level for as long as it's
active. This is the effect every other intensity effect is a variation of —
a `fade` is `full` with an authored transition, a flash is `full` with an entrance
and exit, a strobe is `full` toggling on and off. Reach for it when a
fixture just needs to sit at a level (including off) while something else
in the scene moves or changes. It's also the effect that carries a static
color or beam-shaping choice with nothing else animating.

### `fade`

Exists to give a look a deliberate, authored transition from one value to
another over a set duration — a rise out of darkness, a fall to black, a
dip, a shift to a new color or level. It fades in and fades out
indistinctly: the direction is simply whichever way the ending value sits
relative to the start, not a separate mode. The ending value is always
explicit. The starting
value is optional: when it is given, the fade ignores history and always
starts from that declared value, so the same effect produces the same
visual change whether the fixture was previously off, at some other color,
or mid-strobe; when it is omitted, the fade begins from whatever value the
fixture currently holds, blending out of the live look.

Providing the starting value is a different tool from an ordinary
crossfade transition: a crossfade blends from history, so its effect
depends on what came before it, whereas a `fade` with an explicit floor is
reproducible regardless of context. Reach for the explicit form whenever
the authored change itself is the point — a light rising out of darkness
the same way every time — and omit it when you want the fade to pick up
gracefully from wherever the fixture happens to be.

### `flash`

A percussive hit: the light's job is to mark a single instant and then get
out of the way. An attack/hold/release envelope exists because a real hit
rarely reads as instantaneous square-on — a short attack keeps a
hard-triggered light from looking like a harsh digital cut, and a release
lets the eye register the hit fading rather than vanishing. Reach for
`flash` over `full` plus a separate off-cue whenever the event is short and
self-contained; reach for it over `strobe` when there should be exactly
one pulse, not a repeating pattern.

### `strobe`

A sustained, repeating pulse — the effect for material that calls for
rhythmic, high-energy flashing rather than a single hit: a build, a peak
moment, anything that wants aggression or disorientation. Implementing it
as a driven on/off pattern computed by the controller, rather than relying
on each fixture's own built-in strobe circuitry, exists so that every
fixture in a mixed rig strobes through the same mechanism and one declared
rate means the same thing on every fixture, instead of each model's native
strobe hardware running at its own uncoordinated speed. The trade this
makes deliberately is a rate ceiling — a software-driven strobe can't
outrun the control system's update rate — in exchange for that
cross-fixture consistency and for the rate being a predictable, testable
computation instead of opaque hardware behavior.

---

## Position-domain effects

These answer "where the fixture points, and how it gets there" — never
"how bright." All apply only to fixtures capable of movement (pan/tilt).

### `move_to`

The primitive positioning move: go from wherever the fixture currently is
to one explicit position, once, and stay there. It exists as the raw,
literal building block beneath higher-level positioning effects — useful
when an effect needs a specific raw coordinate that isn't tied to a
meaningful place (a home position, an offset, a hand-chosen angle) rather
than a location the audience should read as significant.

### `move_to_poi`

The effect that actually answers "point at this place," which is the vast
majority of real positioning intent. Its reason for existing separately
from a raw move is that a *place* (a performer, a landmark, a section of
the stage) has a different raw position on every fixture, depending on
where that fixture is mounted and how it's calibrated — a single literal
coordinate points every targeted fixture in the same raw direction, not at
the same physical spot. This effect instead resolves each fixture's own
calibrated value for the named place from a shared table of points of
interest, so one authored effect means "look at X" consistently across a
whole rig, which is what makes place-driven authoring maintainable as
fixtures get moved, replaced, or recalibrated without every use of that
place needing to change.

### `sweep`

Built for the specific dramatic beat of *revealing* something: the fixture
starts elsewhere and dark, travels toward a point, arrives lit at full for
an instant, and continues on, dimming again — one continuous pass that
brightens toward its subject and dims away from it. This is the effect for
a spotlight-style "discover" moment (a beam catching a subject as it
sweeps past, a pose picked out mid-motion) where the light and the
movement are one authored gesture rather than two independently timed
things. The light's envelope and the movement's speed profile are shaped
independently and deliberately — one shapes how the *light* builds and
fades around the reveal, the other shapes how the *movement* accelerates
and decelerates around the same point — because a designer routinely wants
to whip past a point at speed while still bringing the light to a soft
visual peak, or vice versa. It's a one-shot, not a loop: once the pass
ends, the fixture simply holds where it landed.

### `oscillate`

The general back-and-forth pattern generator: continuous motion between
two points for as long as the effect is active, with no lighting behavior
attached. It exists for material that wants rhythmic, repeating movement
as texture — a beam sweeping across a space, tracking a rhythm — where the
motion itself is the content, unlike `sweep`, rather than building toward
a single revealed moment. Offering more than one waveform matters because
different motion shapes read as visibly different qualities of movement —
constant-speed motion with a sharp direction change at each end reads as
mechanical and metronomic, while motion that eases into and out of each
endpoint reads as organic and pendulum-like — and a designer needs both
available depending on the material's feel.

### `seek`

The effect for motion that should look alive or searching rather than
following a fixed, predictable path — filling a region of space with
movement instead of tracing one line. It's a family of patterns because
"alive movement" isn't one shape:

- **`pseudo_random`** — a fixture restlessly wandering a bounded area,
  landing on a new point at intervals and moving on. This is the effect for
  a searching, exploratory quality — lights hunting a space, an unsettled
  or anxious texture — where no two moments should look identical but the
  motion must still be reproducible from the same starting conditions, so
  "random" here means seeded and deterministic rather than actually
  nondeterministic: reproducibility matters whenever an automated show must
  render the same way twice.
- **`circle`** — smooth, continuous, fully predictable orbiting motion with
  no randomness at all. This is for material that wants a region-bounded
  continuous movement but a clean, geometric, repeatable shape instead of a
  wandering one — a rotating beam effect, a mechanical orbit.
- **`pendulum`** — a swing that passes back and forth *through* the center
  point, striking it on every pass, then periodically re-choosing a new
  axis through that center. This is for material that wants the region's
  center to stay visually emphasized (unlike `pseudo_random`, which visits
  it only by chance, and unlike `circle`, which never crosses it at all)
  while still getting continuous, evolving motion — a beam that keeps
  returning to hit the same subject from changing angles.

Choosing between the patterns is choosing what quality of "not holding
still" a moment calls for: erratic and searching, geometric and smooth, or
emphatic and centered.

---

## Shared purpose notes

### Why movement smoothing is computed, not authored

Movement smoothing exists to solve a specific physical-looking problem: a
long, slow move commanded without damping can look mechanically abrupt at
its start and end, while short moves and quick gestures need to stay
snappy and responsive rather than mushy. Deriving smoothing automatically
from how long a movement actually takes — rather than asking every effect
to be authored with the right damping by hand — means the "does this move
need damping" judgment doesn't have to be made, and possibly gotten wrong,
on every use.

### Why out-of-range movement clamps instead of failing

A move that asks for more travel than a fixture can physically complete in
the time given is a common authoring mistake, not a reason to abort
rendering. Clamping to the fixture's rated speed and warning, rather than
rejecting outright, means one over-ambitious effect doesn't block the rest
of a show from rendering, while the warning still surfaces exactly which
effect, fixture, and axis under-traveled — including that the move
genuinely does *not* arrive on time, which matters because whatever
depends on the fixture's position next has to pick up from where it
actually ended up, not from where it was aimed.

### Why intensity and position never share an effect

Keeping the two families disjoint is what makes layering multiple effects
over one fixture at the same time possible at all: a positioning effect
moving a fixture and a brightness effect changing its level can run
concurrently on the same fixture because neither touches the concern the
other owns. If a single effect could express both at once, every pair of
effects would need to know about each other's intensity *and* position
choices to combine safely, instead of composing freely by construction.
