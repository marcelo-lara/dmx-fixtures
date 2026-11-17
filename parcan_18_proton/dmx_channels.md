### 🎛️ DMX Channel Table – Parcan Proton 18 (7ch)

| Channel | DMX Value Range | Function |
|---|---|---|
| 1 | 000–255 | Master dimmer (0–100%) |
| 2 | 000–255 | Red intensity (0–100%) |
| 3 | 000–255 | Green intensity (0–100%) |
| 4 | 000–255 | Blue intensity (0–100%) |
| 5 | 000–003 | Strobe off |
|   | 004–255 | Strobe |
| 6 | 000–049 | Direct RGB channel control |
|   | 050–099 | Jump change (`CE`) |
|   | 100–149 | Gradient change (`CP`) |
|   | 150–199 | Pulse change (`CL`) |
|   | 200–255 | Sound control |
| 7 | 000–255 | Effect speed for channel 6 (slow → fast) |

### Menu Show

| Visible text | Meaning |
|---|---|
| d001–d512 | DMX address code |
| CL00–CL99 | Pulse-change auto mode, speed 0–99 |
| CE00–CE99 | Jump-change auto mode, speed 0–99 |
| CP00–CP99 | Gradient-change auto mode, speed 0–99 |
| b0bE | Sound control |
| R00–R255 | Red from dark to bright, adjustable |
| G00–G255 | Green from dark to bright, adjustable |
| B00–B255 | Blue from dark to bright, adjustable |
| CF00–CF99 | Strobe mode, speed 0–99 from slow to fast |
| C00–C06 | Control selection |

### Optical Breakdown by LED Array Type

* **25°:** standard 18-LED model equipped with individual conical plastic TIR collimator lenses over each 1W diode. This provides a balanced wash with a clear center hotspot and moderate falloff.

### Practical Stage / Studio Projection Math (25° Beam Angle)

For modeling coverage or 3D light-render cones:

$$\text{Beam Diameter} = 2 \times \text{Distance} \times \tan\left(\frac{25^\circ}{2}\right) \approx 0.443 \times \text{Distance}$$

* **At 2 meters:** ~0.89 m wash circle diameter
* **At 3 meters:** ~1.33 m wash circle diameter
* **At 4 meters:** ~1.77 m wash circle diameter

*(Note on color fringing: Because these 7-channel `R, G, B` models use discrete single-color Red, Green, and Blue diodes rather than 3-in-1 RGB chips, expect visible RGB color separation/haloing around the outer ~3°–5° edge of the beam when projecting onto close surfaces).*