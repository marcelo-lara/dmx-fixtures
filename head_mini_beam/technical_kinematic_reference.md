### 1. Physical Architecture & Kinematics

| Parameter | Specification | Mechanical Context |
| --- | --- | --- |
| **Optical Engine** | 100W–150W High-Power White LED + Collimator Lens | Tight beam angle (**~1.5° – 2.5°**), deeper barrel/head length than the spot version. |
| **Head Payload Mass** | ~1.4 – 1.8 kg (moving head assembly alone) | Heavier than the 10W–30W spot due to the larger aluminum heatsink, cooling fan, and motorized prism swing arm. |
| **Pan (X-Axis) Range** | **540°** (1.5 full turns) | Belt-driven (GT2/MXL timing belt) via NEMA 14 / NEMA 17 stepper motor; optical/Hall home sensor. |
| **Tilt (Y-Axis) Range** | **180°** *(or 200° depending on end-stop)* | Belt-driven via NEMA 14 stepper motor; hard mechanical stops at end-of-travel. |
| **Position Resolution** | **16-bit (65,536 microsteps)** | $\approx 0.0082^\circ/\text{step}$ on Pan; $\approx 0.0027^\circ/\text{step}$ on Tilt. |
| **Color & Gobo Wheels** | 28BYJ-48 / small bipolar micro-steppers | Indexed via magnetic Hall-effect sensors on the wheel hubs (allows bidirectional continuous spin). |
| **Prism Mechanism** | Dual-motor assembly (Swing + Spin) | 1 stepper/servo swings the 3-facet or 18-facet prism into the optical path; a second micro-stepper spins the prism holder. |

---

### 2. Pan & Tilt Travel Speeds (Channel 5 Behavior)

Because this chassis carries greater rotational inertia (heavier heatsink and prism module) than the small EL-150B, the firmware runs slightly gentler acceleration/deceleration ramps to prevent belt skipping:

#### **A. Pan Axis (540° Full Sweep: DMX `0` $\to$ `65535`)**

* **Max Speed (`CH 5 = 0` / Tracking Mode):**
* **Full 540° Travel Time:** **~2,200 ms to 2,600 ms** (~2.4 seconds average).
* **Peak Angular Velocity ($\omega_{\max}$):** $\approx 220^\circ/\text{s} \text{ to } 245^\circ/\text{s}$.
* **Accel / Decel Ramping:** **~180 ms – 250 ms** per ramp.


* **Min Speed (`CH 5 = 255` / Max Vector Damping):**
* **Full 540° Travel Time:** **~28,000 ms to 34,000 ms** (~31 seconds average).
* **Minimum Angular Velocity ($\omega_{\min}$):** $\approx 16^\circ/\text{s} \text{ to } 19^\circ/\text{s}$.



#### **B. Tilt Axis (180° Full Sweep: DMX `0` $\to$ `65535`)**

* **Max Speed (`CH 5 = 0` / Tracking Mode):**
* **Full 180° Travel Time:** **~900 ms to 1,150 ms** (~1.0 second average).
* **Peak Angular Velocity ($\omega_{\max}$):** $\approx 175^\circ/\text{s} \text{ to } 200^\circ/\text{s}$.
* **Accel / Decel Ramping:** **~120 ms – 180 ms** per ramp.


* **Min Speed (`CH 5 = 255` / Max Vector Damping):**
* **Full 180° Travel Time:** **~11,000 ms to 14,000 ms** (~12.5 seconds average).
* **Minimum Angular Velocity ($\omega_{\min}$):** $\approx 13^\circ/\text{s} \text{ to } 16^\circ/\text{s}$.



---

### 3. Speed Lookup Table (Channel 5 Scaling)

| CH 5 Value | Mode | Full 540° Pan Time | Full 180° Tilt Time | Pan / Tilt Time Ratio |
| --- | --- | --- | --- | --- |
| **`0`** | Tracking (Max Velocity) | **~2,400 ms** | **~1,000 ms** | **2.4 : 1** |
| **`64`** | Light Vector Slew | **~8,500 ms** | **~3,500 ms** | **2.4 : 1** |
| **`128`** | Medium Vector Slew | **~16,500 ms** | **~6,800 ms** | **2.4 : 1** |
| **`192`** | Heavy Vector Slew | **~24,000 ms** | **~10,000 ms** | **2.4 : 1** |
| **`255`** | Max Damping (Slowest) | **~31,000 ms** | **~12,500 ms** | **2.48 : 1** |

---

### 4. Sub-System Mechanical Latencies (Optical Effects)

When sequencing tight musical cues, keep these internal mechanical transition times in mind:

1. **Color Wheel Indexing (CH 8):**
* **Adjacent Slot Switch:** **~60 ms – 90 ms**.
* **180° Opposite Slot Switch (e.g., Open to Color 6):** **~180 ms – 250 ms**.
* *Note:* Because the wheel supports bidirectional rotation, the firmware takes the shortest path between static color slots (`000–119`).


2. **Gobo Wheel Indexing (CH 9):**
* **Adjacent Slot Switch (14-gobo density):** **~45 ms – 70 ms** (slots are spaced every ~24° around the disc).
* **Opposite Side Switch:** **~200 ms – 280 ms**.
* *Tip:* If you want an instant "snap" gobo change without seeing intermediate gobos flash across the beam, drop **CH 6 (Dimmer) to `0**` for ~150 ms during the transition.


3. **Prism Insertion & Spin (CH 10):**
* **Swing Arm Engage / Disengage (`127` $\leftrightarrow$ `128`):** **~220 ms – 320 ms** (driven by a small geared stepper swinging the prism carrier into the light path; produces an audible soft click/whir).
* **Prism Rotation Spin-up (`136` $\to$ `255`):** Instantaneous response (~30 ms latency) since the rotation motor is mounted directly on the prism carrier.



---

### 5. Kinematic Formulas for Software Trajectory Control

To drive linear, synchronized beam paths from external software (keeping **CH 5 = `0**`):

$$\text{Pan}_{\text{deg}} = \left(\frac{(\text{CH}_1 \times 256) + \text{CH}_2}{65535}\right) \times 540^\circ$$

$$\text{Tilt}_{\text{deg}} = \left(\frac{(\text{CH}_3 \times 256) + \text{CH}_4}{65535}\right) \times 180^\circ$$

* **Minimum Safe Move Duration ($T_{\min}$)** between two points $(P_1, T_1)$ and $(P_2, T_2)$ without outrunning the steppers:

$$T_{\min} = \max\left( \frac{\vert{}\Delta P_{\text{deg}}\vert{}}{225^\circ/\text{s}} + 0.20\text{s}, \quad \frac{\vert{}\Delta T_{\text{deg}}\vert{}}{180^\circ/\text{s}} + 0.15\text{s} \right)$$