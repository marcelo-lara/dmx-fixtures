# DMX fixtures

## Reference

- Use with [Freestyler2](https://www.freestylerdmx.be/)
- copy fixtures to freestyler folder
    - copy Gobos folder

## DarkBlue settings

**Universe 1**
|CH   | device         |
|-----|----------------|
|01-15| Head EL-150    |
|16-21| Parcan RGB 18  |
|22-27| Parcan RGB 18  |


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