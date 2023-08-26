@ECHO OFF

REM Head EL150
mklink /H %USERPROFILE%"\QLC+\Fixtures\DarkBlue-Head-EL150.qxf" %USERPROFILE%"\dmx-fixtures\head_el150\DarkBlue-Head-EL150.qxf"
mklink /J "C:\QLC+\Gobos\EL150" %USERPROFILE%"\dmx-fixtures\head_el150\Gobos\EL150"

REM Parcan 18
mklink /H %USERPROFILE%"\QLC+\Fixtures\DarkBlue-ParCan18.qxf" %USERPROFILE%"\dmx-fixtures\parcan_18\DarkBlue-ParCan18.qxf"