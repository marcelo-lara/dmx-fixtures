# DMX fixtures

## DarkBlue settings

### Universe 1
|CH           | device                      |
|-------------|----------------------------|
|01-12        | Head EL-150 (12ch)         |
|13-15        | (unused / reserved)        |
|16-21        | Parcan RGB 18 (L)          |
|22-27        | Parcan RGB 18 (R)          |
|28-34        | Parcan Proton18 (L)        |
|35-41        | Parcan Proton18 (R)        |
|42-53        | Mini Beam Prism (L)        |
|54-65        | Mini Beam Prism (R)        |

#### QLC+ patch (from workspace)

- QLC+ workspace: `DarkBlue_office.qxw` (QLC+ 5.2.0)
- Universe 1 output: ArtNet -> `192.168.10.44`
- Universe 1 input/feedback: MIDI (Novation Launchpad)



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
| 008     | Color Wheel      | 0–23 white, 24–47 orange, 48–71 cyan, 72–95 purple, 96–119 yellow, 120–143 green, 144–167 blue, 168–191 red, 192–255 color move (slow→fast) |
| 009     | Gobo Wheel       | 0–11 open, 12–23 gobo 1, 24–35 gobo 2, 36–47 gobo 3, 48–59 gobo 4, 60–71 gobo 5, 72–83 gobo 6, 84–95 gobo 7, 96–255 shake/move effects |
| 010     | Auto Play Select | 0–7 empty, 8–47 auto 1, 48–87 auto 2, 88–127 auto 3, 128–167 auto 4, 168–207 auto 5, 208–247 auto 6, 248–255 color/gobo sound control |
| 011     | XY Auto Run      | 0–7 empty, 8–32 run 1, 33–58 run 2, 59–84 run 3, 85–110 run 4, 111–136 run 5, 137–162 run 6, 163–188 run 7, 189–239 run 8, 241–255 sound control |
| 012     | Reset            | 250–255: Reset motors (10 sec)                            |

#### Parcan RGB 18 (6ch)

| Channel | Function               | DMX Range & Meaning                 |
| ------- | ---------------------- | ----------------------------------- |
| 001     | Light (master dimmer)  | 0–255: Overall brightness           |
| 002     | Red (intensity)        | 0–255                               |
| 003     | Green (intensity)      | 0–255                               |
| 004     | Blue (intensity)       | 0–255                               |
| 005     | Strobe                 | 1–255: slow → fast (0 = off)        |
| 006     | Color Change Mode      | 1–255: built-in color change modes  |

#### Parcan Proton 18 (6ch)

| Channel | Function               | DMX Range & Meaning                 |
| ------- | ---------------------- | ----------------------------------- |
| 001     | Light (master dimmer)  | 0–255: Overall brightness           |
| 002     | Red (intensity)        | 0–255                               |
| 003     | Green (intensity)      | 0–255                               |
| 004     | Blue (intensity)       | 0–255                               |
| 005     | Strobe                 | 1–255: slow → fast (0 = off)        |
| 006     | Color Change Mode      | 1–255: built-in color change modes  |

#### Mini Beam Prism (12ch)

| Channel | Function            | DMX Range & Meaning |
| ------- | ------------------- | ------------------- |
| 001     | Pan (X)             | 0–255               |
| 002     | Pan Fine            | 0–255               |
| 003     | Tilt (Y)            | 0–255               |
| 004     | Tilt Fine           | 0–255               |
| 005     | Pan/Tilt Speed      | 0–255 (fast → slow) |
| 006     | Dimmer              | 0–255               |
| 007     | Strobe              | 0–10 off, 11–255 slow → fast |
| 008     | Color               | 0–9 open/white, 10–119 colors, 120–189 forward rotation, 190–255 reverse rotation |
| 009     | Gobo                | 0–5 open, 6–75 gobos, 81–150 shake, 151–200 forward rotation, 201–255 reverse rotation |
| 010     | Prism               | 0–127 off, 128–135 on, 136–255 rotate (slow → fast) |
| 011     | Auto / Sound        | 0–29 none, 30–149 auto, 150–255 sound modes |
| 012     | Reset               | 0–249 none, 250–255 reset (hold ~3s) |

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
