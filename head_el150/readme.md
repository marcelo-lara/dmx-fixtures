
# Head EL-150

## Channels Mapping

| Channel | Function         | DMX Range & Meaning                                       |
| ------- | ---------------- | --------------------------------------------------------- |
| 001     | Pan (X)          | 0–255: Pan position                                       |
| 002     | Pan Fine         | 0–255: Finer pan movement                                 |
| 003     | Tilt (Y)         | 0–255: Tilt position                                      |
| 004     | Tilt Fine        | 0–255: Finer tilt movement                                |
| 005     | XY Speed         | 0–255: Movement speed (slow to fast)                      |
| 006     | Dimmer           | 0–255: 0 = off, 255 = full intensity                      |
| 007     | Shutter / Strobe | 0–9 = closed, 10–250 = strobe (slow→fast), 251–255 = open |
| 008     | Color Wheel      | 0–255: Colors 1–7 + rainbow, see manual for ranges        |
| 009     | Gobo Wheel       | 0–255: Gobos 1–7 + shake + motion, see manual for ranges  |
| 010     | Auto Play Select | 0–255: Presets 1–6, 248–255 = Color+Gobo+Sound            |
| 011     | XY Auto Run      | 0–255: Auto XY sequences 1–8 + Sound Control              |
| 012     | Reset            | 250–255: Reset motors (10 sec)                            |

## Color Wheel (channel 8)

| Value | Color Name        | Image |
| ----- | ----------------- | ------| 
|     0 | White             | ![white](Gobos/EL150/el150_color_0.gif)
|    25 | Orange            | ![white](Gobos/EL150/el150_color_1.gif) 
|    50 | Cyan              | ![white](Gobos/EL150/el150_color_2.gif)
|    75 | Purple            | ![white](Gobos/EL150/el150_color_3.gif)  
|   100 | Yellow            | ![white](Gobos/EL150/el150_color_4.gif) 
|   125 | Green             | ![white](Gobos/EL150/el150_color_5.gif)
|   150 | Blue              | ![white](Gobos/EL150/el150_color_6.gif)
|   175 | Red               | ![white](Gobos/EL150/el150_color_7.gif)

## Gobo Wheel (channel 9)

| Value | Color Name        | Image |
| ----- | ----------------- | ------| 
|     0 | White             | ![white](Gobos/EL150/el150_gobo_0.gif)
|    25 | Orange            | ![white](Gobos/EL150/el150_gobo_1.gif)   
|    50 | Cyan              | ![white](Gobos/EL150/el150_gobo_2.gif)
|    75 | Purple            | ![white](Gobos/EL150/el150_gobo_3.gif)    
|   100 | Yellow            | ![white](Gobos/EL150/el150_gobo_4.gif)   
|   125 | Green             | ![white](Gobos/EL150/el150_gobo_5.gif)
|   150 | Blue              | ![white](Gobos/EL150/el150_gobo_6.gif)
|   175 | Red               | ![white](Gobos/EL150/el150_gobo_7.gif) 
