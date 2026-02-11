# DMX fixtures

## DarkBlue settings

### Universe 1
|CH           | device                      |
|-------------|----------------------------|
|01-15        | Head EL-150                |
|16-21        | Parcan RGB 18 (L)          |
|22-27        | Parcan RGB 18 (R)          |
|28-34        | Parcan Proton18 (L)        |
|35-41        | Parcan Proton18 (R)        |
|42-53        | Parcan Proton18 (R)        |
|54-65        | Parcan Proton18 (R)        |



### Fixtures

#### Head EL-150
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

#### PAR Can (old)

| Channel | Function          | DMX Range & Meaning                   |
| ------- | ----------------- | ------------------------------------- |
| 016     | Master Dimmer     | 0–255: Overall brightness             |
| 017     | Red               | 0–255: Red intensity                  |
| 018     | Green             | 0–255: Green intensity                |
| 019     | Blue              | 0–255: Blue intensity                 |
| 020     | Strobe            | 1–255: Slow to fast strobe (0 = off?) |
| 021     | Auto Color Change | 1–255: Various color change presets   |

#### PAR Can (old)

| Channel | Function          | DMX Range & Meaning                   |
| ------- | ----------------- | ------------------------------------- |
| 016     | Master Dimmer     | 0–255: Overall brightness             |
| 017     | Red               | 0–255: Red intensity                  |
| 018     | Green             | 0–255: Green intensity                |
| 019     | Blue              | 0–255: Blue intensity                 |
| 020     | Strobe            | 1–255: Slow to fast strobe (0 = off?) |
| 021     | Auto Color Change | 1–255: Various color change presets   |


## QLC+

1. Install QLC+ from https://www.qlcplus.org/
2. link the fixtures (command line)
    ```bash
    qlc_bootstrap.cmd
    ```
3. update the shortcut to start QLC+ with the correct workspace
    ```bash
    C:\QLC+\qlcplus.exe -o %USERPROFILE%\dmx-fixtures\DarkBlue_office.qxw
    ```
## Freestyler

1. Install [Freestyler2](https://www.freestylerdmx.be/)
2. copy fixtures to freestyler folder
3. copy Gobos folder
