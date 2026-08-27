# Fixture configuration

The configuration separates reusable fixture models from the physical DMX
patch:

- `fixtures.json` defines fixture models and their DMX control layouts.
- `dmx_patch.json` defines installed fixture instances, their start addresses,
  and their positions in the show layout.
- `pois.json` is the sole source of points of interest (POIs) and calibrated
  pan/tilt targets for fixture instances.

Current model IDs are `head_prism`, `head_el150`, `parcan`, and `proton`.
`parcan` is the five-channel ParCan 18 profile; `proton` is the six-channel
ParCan 18 Proton profile.

## Fixture models (`fixtures.json`)

`fixtures.json` is an array of reusable model definitions.

| Field | Type | Description |
| --- | --- | --- |
| `id` | string | Unique model ID, referenced by `dmx_patch.json`. |
| `name` | string | Human-readable model name. |
| `type` | string | Fixture family; current values are `moving_head` and `rgb`. |
| `channels` | object | Maps controls to 1-based channel offsets within the model's DMX footprint. |
| `effects` | string array | Effects supported by the model. |
| `arm` | object | DMX values used to arm or enable the fixture. |
| `meta` | object | Control metadata, documented wheel values, and movement travel times. |

Channel offsets must match the fixture's selected DMX mode. The first channel
of every model is offset `1`.

## DMX patch (`dmx_patch.json`)

`dmx_patch.json` is an array of physical fixture instances.

| Field | Type | Description |
| --- | --- | --- |
| `id` | string | Unique instance ID. POIs reference this ID. |
| `name` | string | Human-readable installed-fixture name. |
| `fixture_model` | string | Model ID from `fixtures.json`. |
| `start_address` | integer | Absolute, 1-based DMX address for the first model channel. |
| `location` | object | Numeric `x`, `y`, and `z` coordinates in the show-layout coordinate system. |

Resolve a model channel to its absolute DMX address with:

```text
address = start_address + channel_offset - 1
```

Resolved channel ranges must not overlap across patched instances. Current
fixture values are runtime application state and are not stored in either file.

For example, the Mini Beam Prism model's `pan_msb` offset is `1`; for the
`head_prism_l` instance at start address `42`, it resolves to DMX channel
`42`.

## Channels and values

Common 8-bit controls include `dim`, `strobe` or `shutter`, `red`, `green`,
`blue`, `color`, `gobo`, `prism`, `speed`, `program`, `autoplay`, and `reset`.
Their values are normally integers from `0` to `255`.

Pan and tilt positions use paired 16-bit controls:

```json
"pan_msb": 1,
"pan_lsb": 2,
"tilt_msb": 3,
"tilt_lsb": 4
```

Pan and tilt values are integers from `0` to `65535`; the controller sends the
high byte to `_msb` and the low byte to `_lsb`.

## POIs and effects

POIs live in `pois.json`, never in a fixture model or patch entry. A POI has a
stable `id`, display `name`, layout `location`, and a `fixtures` map keyed by
patch-instance ID. Each map entry provides that instance's calibrated 16-bit
`pan` and `tilt` target:

```json
{
  "id": "piano_center",
  "fixtures": {
    "head_prism_l": { "pan": 45648, "tilt": 4871 }
  }
}
```

Effects list and purpose are explained in detail in `effects_reference.md`

Typical moving-head effects are `full`, `strobe`, `flash`, `fade_in`, `seek`,
`move_to`, `move_to_poi`, and `sweep`. RGB fixtures currently expose `full`,
`strobe`, `flash`, and `fade_in`.

## Metadata

`meta.channel_types` maps logical controls to presentation/behavior types.
Current types are `position_16bit`, `dimmer`, `color`, `strobe`, `wheel`, and
`prism`.

`meta.value_mappings` is optional. It maps numeric DMX values (stored as JSON
object keys) to labels, such as color-wheel slots or strobe speeds. For
`color` and `gobo` wheels, each entry is an object with a `label` plus either:

- `color`, a hex RGB string (e.g. `"#FF0000"`) for color-wheel slots, sampled
  from the wheel's swatch — used to render a color chip in a UI without
  shipping an image; or
- `image`, a path to an SVG of the gobo pattern, relative to `config/`.

Slots with neither (e.g. rotation modes, shake) have no `color`/`image`.
Gobo images live under `config/assets/<model_id>/gobo/`, kept inside `config/`
since it's the only folder shared with consumers.

`meta.travel_time_ms` is required for `moving_head` models and gives the time,
in milliseconds, for an axis to traverse its **full 16-bit range** (0 to 65535)
with no smoothing applied — that is, at `speed` 0. `pan` and `tilt` are stated
separately so they can differ per model:

```json
"travel_time_ms": {
  "pan": 2000,
  "tilt": 800
}
```

Controllers use it to check whether a timed movement is physically achievable.
The implied maximum rate is `65535 / travel_time_ms` DMX units per millisecond.

## Minimal patch example

```json
{
  "id": "parcan_l",
  "name": "ParCan L",
  "fixture_model": "parcan",
  "start_address": 16,
  "location": { "x": 0.25, "y": 0, "z": 0 }
}
```
