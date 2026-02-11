Mini Beam Prism Moving Head – User Manual

Purpose: Text-only, normalized manual suitable for Copilot indexing, RAG ingestion, and semantic search.
Source: Cleaned from scanned user manual. Tables normalized, duplicates removed, wording clarified.

⸻

1. Safety Information

⚠️ CAUTION
	•	Keep this device away from rain and moisture.
	•	Disconnect mains power before opening the housing.
	•	Installation, operation, and maintenance must be performed by qualified personnel only.

General Safety Rules
	•	Never stand directly beneath the unit during installation, removal, or servicing.
	•	Maintain at least 0.5 m (1.5 ft) distance from flammable materials.
	•	Ensure all mounting points can support 10× the weight of the fixture.
	•	Always use secondary safety devices (e.g., safety cables) for overhead installation.

⸻

2. Introduction

Thank you for choosing this professional moving head light. This unit is designed to be powerful, compact, and versatile for stage and event lighting applications.

Package Contents
	•	1 × Mini Beam Prism Moving Head Light
	•	1 × Power Cable
	•	1 × DMX (XLR) Cable
	•	1 × User Manual
	•	1 × Bow Mount
	•	2 × Mounting Screws

Inspect the unit for transport damage before use. Do not install if damage is present.

⸻

3. Mounting and Installation

3.1 Mounting Guidelines
	•	Suitable for truss or surface mounting.
	•	Ensure all installation hardware is rated for the fixture load.
	•	Complete mechanical installation before connecting power.

3.2 Installation Bracket (Bow Mount)
	1.	Attach the bow mount to the bottom of the fixture using the supplied screws.
	2.	Secure the clamp or hook to the bow mount.
	3.	Ensure the hook is properly locked to the truss.
	4.	Attach a safety cable as a secondary restraint.

⸻

4. DMX-512 Control Connection
	•	Use a 3-pin XLR DMX cable.
	•	Connect the DMX controller output to the fixture DMX input.
	•	Daisy-chain additional fixtures using DMX OUT → DMX IN.
	•	Recommended cable: shielded, two-conductor DMX cable.

Supported Operating Modes
	•	DMX-512
	•	Auto Run
	•	Sound Activated
	•	Master / Slave

⸻

5. Technical Specifications
	•	Input Voltage: AC 110–240 V, 50/60 Hz
	•	Light Source: 1 × 250 W White High Power LED
	•	Power Consumption: 230 W
	•	Beam Angle: 1.5°
	•	Strobe: Up to 25 Hz
	•	Prism: 1 × 24-facet rotating prism (no zoom)
	•	Control Channels: 12
	•	Pan: 540° (speed controllable)
	•	Tilt: 220° (speed controllable)
	•	Color Wheel: 11 colors + open, bidirectional rotation
	•	Gobo Wheel: 14 gobos + shake + rotation
	•	Dimmer: 0–100% linear
	•	Display: 4-digit LED
	•	Net Weight: 5.5 kg
	•	Gross Weight: 6.3 kg
	•	Packing Size: 37.5 × 27 × 27.5 cm

⸻

6. Control Panel & Menu

Buttons
	•	MENU – Select menu
	•	UP / DOWN – Change values
	•	ENTER – Confirm selection

Menu Structure

Menu	Description
Addr	DMX Address (1–512)
Chnd	Channel Mode (12ch)
SLnd	Slave Mode
Auto	Auto Mode
Sound	Sound Activated Mode
SH0–SH3	Show Programs 1–4
Sens	Sound Sensitivity (10–100)
Led	Display On/Off
Disp	Display Normal / Inverted
rPan	Pan Reverse
rTil	Tilt Reverse
Rest	Reset Fixture
temp	Temperature Display

Menu auto-exits after 5 seconds of inactivity.

⸻

7. DMX Channel Map (12 Channels)

Channel Overview

Ch	Function	Values
1	Pan	0–255
2	Pan Fine	0–255
3	Tilt	0–255
4	Tilt Fine	0–255
5	Pan/Tilt Speed	Fast → Slow
6	Dimmer	0–255
7	Strobe	0–10 Off, 11–255 Slow → Fast

Color Wheel (Ch 8)

Value	Color
0–9	White
10–19	Color 1
20–29	Color 2
30–39	Color 3
40–49	Color 4
50–59	Color 5
60–69	Color 6
70–79	Color 7
80–89	Color 8
90–99	Color 9
100–119	Color 10
120–189	Forward Color Rotation (Fast → Slow)
190–255	Reverse Color Rotation (Slow → Fast)

Gobo Wheel (Ch 9)

Value	Function
0–5	Open
6–75	Gobos 1–14
76–80	Open
81–150	Gobo Shake
151–200	Forward Gobo Rotation
201–255	Reverse Gobo Rotation

Prism (Ch 10)

Value	Function
0–127	Prism Off
128–135	Prism On
136–255	Prism Rotation Slow → Fast

Macro Programs (Ch 11)

Value	Program
0–29	No Function
30–59	Auto 1
60–89	Auto 2
90–119	Auto 3
120–149	Auto 4
150–179	Sound 1
180–209	Sound 2
210–239	Sound 3
240–255	Sound 4

Reset (Ch 12)

Value	Action
0–249	No Function
250–255	Reset (hold 3 seconds)


⸻

8. Notes for Programming & Shows
	•	Best visual results achieved when combined with haze or fog.
	•	Avoid keeping fixtures static for long durations to reduce LED thermal stress.
	•	Use slow pan/tilt speeds for beam choreography; fast speeds for accents.

⸻

9. RAG / Copilot Usage Notes

Recommended chunking:
	•	Sections 1–3: Safety & Installation
	•	Section 5: Technical Specs
	•	Section 6: Menu
	•	Section 7: DMX Channel Map (split per channel group)

Tags:
lighting, dmx512, moving-head, beam, prism, 12-channel, stage-lighting
