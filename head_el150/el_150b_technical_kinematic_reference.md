# Fixture Profile: E-Lighting EL-150B (OEM Mini LED Spot 10W-15W)

## 1. Fixture Overview & Hardware Architecture
- **Brand / Distributor**: E-Lighting (Argentina / LatAm)
- **Model**: EL-150B
- **Hardware Platform**: Generic Guangzhou OEM Mini LED Gobo Spot (10W-15W Cree/Epistar LED)
- **Equivalent / Cross-Compatible Fixtures**: 
  - Optonica LED 984
  - MyLite 10W Mini Spot
  - UKing / Lixada 10W-30W Mini Gobo Spot (12-Channel variants)
  - Generic "Mini LED Spot 12CH"
- **Light Source**: 10W-15W Cold White LED (~6500K-8000K)
- **Optics**: Manual focus objective lens, ~13° beam angle, 1500 Lux @ 3m
- **Mechanical Pan Range**: $540^\circ$
- **Mechanical Tilt Range**: $190^\circ$ (Mechanical hard stop limit, not 270°)
- **Stepper Resolution**: 16-bit positioning (Coarse + Fine)

---

## 2. Motion Kinematics & Timing (Pan & Tilt)

### 2.1 Coordinate Conversion Formulas
For 16-bit resolution control ($DMX_{16} \in [0, 65535]$):
$$DMX_{16} = (\text{Channel}_{\text{Coarse}} \times 256) + \text{Channel}_{\text{Fine}}$$
$$\text{Pan Angle } (\theta_{\text{Pan}}) = \left( \frac{DMX_{16}}{65535} \right) \times 540^\circ$$
$$\text{Tilt Angle } (\theta_{\text{Tilt}}) = \left( \frac{DMX_{16}}{65535} \right) \times 190^\circ$$

For 8-bit resolution control ($DMX_{8} \in [0, 255]$):
$$\theta_{\text{Pan}} = \left( \frac{DMX_{8}}{255} \right) \times 540^\circ$$
$$\theta_{\text{Tilt}} = \left( \frac{DMX_{8}}{255} \right) \times 190^\circ$$

---

### 2.2 Speed Channel (CH 5) Behavior
Channel 5 operates as an internal slew-rate limiter / step-pulse timer delay:
- **Value `0` (or `0-3`)**: Tracking Mode. Fixture runs at maximum microcontroller pulse rate and acceleration limits.
- **Value `1 - 255`**: Vector Mode. Higher values increase the delay between stepper motor step pulses, smoothing motion and decreasing velocity.

---

### 2.3 Measured / Empirical Travel Times (Full End-to-End Travel: 0 to 255)

#### Pan Axis ($540^\circ$ Travel)
| DMX Value (CH 5) | Mode / Behavior | Duration (ms) | Duration (s) | Mean Angular Velocity ($\omega$) |
| :---: | :--- | :---: | :---: | :---: |
| `0` | Tracking (Max Velocity) | **1,800 – 2,200 ms** | ~2.0 s | $\approx 270^\circ/\text{s}$ |
| `64` | 25% Slew Damping | **7,000 – 8,500 ms** | ~7.8 s | $\approx 70^\circ/\text{s}$ |
| `128` | 50% Slew Damping | **14,000 – 16,000 ms** | ~15.0 s | $\approx 36^\circ/\text{s}$ |
| `192` | 75% Slew Damping | **20,000 – 23,000 ms** | ~21.5 s | $\approx 25^\circ/\text{s}$ |
| `255` | Max Slew (Slowest) | **26,000 – 32,000 ms** | ~28.0 s | $\approx 18^\circ/\text{s}$ |

*Pan Acceleration/Deceleration Ramps*: $\approx 150 - 200\text{ ms}$ trapezoidal ramp.

#### Tilt Axis ($190^\circ$ Travel)
| DMX Value (CH 5) | Mode / Behavior | Duration (ms) | Duration (s) | Mean Angular Velocity ($\omega$) |
| :---: | :--- | :---: | :---: | :---: |
| `0` | Tracking (Max Velocity) | **750 – 950 ms** | ~0.85 s | $\approx 220^\circ/\text{s}$ |
| `64` | 25% Slew Damping | **2,800 – 3,500 ms** | ~3.1 s | $\approx 60^\circ/\text{s}$ |
| `128` | 50% Slew Damping | **5,500 – 6,500 ms** | ~6.0 s | $\approx 32^\circ/\text{s}$ |
| `192` | 75% Slew Damping | **8,000 – 9,500 ms** | ~8.7 s | $\approx 22^\circ/\text{s}$ |
| `255` | Max Slew (Slowest) | **10,000 – 13,000 ms** | ~11.5 s | $\approx 16^\circ/\text{s}$ |

*Tilt Acceleration/Deceleration Ramps*: $\approx 100 - 150\text{ ms}$ trapezoidal ramp.

---

## 3. DMX-512 Channel Mapping

### 3.1 12-Channel Advanced Mode (`ChMd = CH12`)

| Channel | Function | Value Range | Details |
| :---: | :--- | :---: | :--- |
| **1** | Pan (X Coarse) | `000 - 255` | Horizontal position $0^\circ \to 540^\circ$ (MSB) |
| **2** | Pan Fine (X Fine) | `000 - 255` | 16-bit fine positioning (LSB) |
| **3** | Tilt (Y Coarse) | `000 - 255` | Vertical position $0^\circ \to 190^\circ$ (MSB) |
| **4** | Tilt Fine (Y Fine) | `000 - 255` | 16-bit fine positioning (LSB) |
| **5** | Pan/Tilt Speed | `000 - 255` | `0`: Max speed / Tracking; `1 - 255`: Vector damping (fast $\to$ slow) |
| **6** | Master Dimmer | `000 - 255` | 0% to 100% linear PWM dimming |
| **7** | Shutter / Strobe | `000 - 009`<br>`010 - 250`<br>`251 - 255` | Shutter Closed / Blackout<br>Strobe effect (Slow ~1 Hz $\to$ Fast ~20 Hz)<br>Shutter Open / Normal On |
| **8** | Color Wheel | `000 - 023`<br>`024 - 047`<br>`048 - 071`<br>`072 - 095`<br>`096 - 119`<br>`120 - 143`<br>`144 - 167`<br>`168 - 191`<br>`192 - 255` | Open (White)<br>Color 1 (Red)<br>Color 2 (Orange/Amber)<br>Color 3 (Yellow)<br>Color 4 (Green)<br>Color 5 (Cyan/Light Blue)<br>Color 6 (Magenta/Pink)<br>Color 7 (Dark Blue)<br>Continuous Color Scroll / Rainbow (Slow $\to$ Fast) |
| **9** | Gobo Wheel | `000 - 011`<br>`012 - 023`<br>`024 - 035`<br>`036 - 047`<br>`048 - 059`<br>`060 - 071`<br>`072 - 083`<br>`084 - 095`<br>`096 - 111`<br>`112 - 127`<br>`128 - 143`<br>`144 - 159`<br>`160 - 175`<br>`176 - 191`<br>`192 - 255` | Open (Clear)<br>Gobo 1<br>Gobo 2<br>Gobo 3<br>Gobo 4<br>Gobo 5<br>Gobo 6<br>Gobo 7<br>Gobo 1 Shake (Slow $\to$ Fast)<br>Gobo 2 Shake (Slow $\to$ Fast)<br>Gobo 3 Shake (Slow $\to$ Fast)<br>Gobo 4 Shake (Slow $\to$ Fast)<br>Gobo 5 Shake (Slow $\to$ Fast)<br>Gobo 6 Shake (Slow $\to$ Fast)<br>Continuous Gobo Scroll (Slow $\to$ Fast) |
| **10** | Macro / Auto Play | `000 - 007`<br>`008 - 047`<br>`048 - 087`<br>`088 - 127`<br>`128 - 167`<br>`168 - 207`<br>`208 - 247`<br>`248 - 255` | Disabled / Manual DMX<br>Auto Program 1<br>Auto Program 2<br>Auto Program 3<br>Auto Program 4<br>Auto Program 5<br>Auto Program 6<br>Sound Active (Color + Gobo) |
| **11** | Movement Macros | `000 - 007`<br>`008 - 032`<br>`033 - 058`<br>`059 - 084`<br>`085 - 110`<br>`111 - 136`<br>`137 - 162`<br>`163 - 188`<br>`189 - 239`<br>`240 - 255` | Disabled / Manual Pan/Tilt<br>Auto Pan/Tilt Movement 1<br>Auto Pan/Tilt Movement 2<br>Auto Pan/Tilt Movement 3<br>Auto Pan/Tilt Movement 4<br>Auto Pan/Tilt Movement 5<br>Auto Pan/Tilt Movement 6<br>Auto Pan/Tilt Movement 7<br>Auto Pan/Tilt Movement 8<br>Sound Active Pan/Tilt Movement |
| **12** | Fixture Reset | `000 - 249`<br>`250 - 255` | Normal operation<br>Reset all stepper motors (Hold > 5 seconds) |

---

### 3.2 4-Channel Basic Mode (`ChMd = CH4`)

| Channel | Function | Value Range | Details |
| :---: | :--- | :---: | :--- |
| **1** | Pan (X) | `000 - 255` | 8-bit Pan position ($0^\circ \to 540^\circ$) |
| **2** | Tilt (Y) | `000 - 255` | 8-bit Tilt position ($0^\circ \to 190^\circ$) |
| **3** | Auto Color/Gobo | `000 - 007`<br>`008 - 247`<br>`248 - 255` | Manual / No Macro<br>Preset Auto Program 1-6<br>Sound Active (Color & Gobo) |
| **4** | Auto Pan/Tilt | `000 - 007`<br>`008 - 239`<br>`240 - 255` | Manual / No Macro<br>Preset Movement Patterns 1-8<br>Sound Active Movement |

---

## 4. Onboard Control Panel Menu

| Menu Item | Values | Function |
| :--- | :--- | :--- |
| `Addr` | `001 - 512` | Set DMX starting address |
| `ChMd` | `CH 4`, `CH 12` | Select channel profile mode |
| `SLMd` | `MAST`, `SLAV` | Master standalone or Slave mode |
| `SHMd` | `001 - 008` | Internal standalone auto-show preset |
| `Soun` | `OFF`, `ON` | Microphone sound sensitivity mode |
| `PAN` | `OFF`, `ON` | Pan motor invert |
| `TIL` | `OFF`, `ON` | Tilt motor invert |
| `dISP` | `OFF`, `ON` | Display 180° flip (for inverted truss rigging) |
| `rFAC` | `OFF`, `ON` | Factory reset to defaults |
| `rST` | *Trigger* | Recalibrate and home stepper motors |