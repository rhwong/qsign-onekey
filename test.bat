@echo off
setlocal enabledelayedexpansion
set JAVA_HOME=.\jre
set "ver=1.1.3"
set "library=txlib/"
set "txlib_version=8.9.63"
set "host=0.0.0.0"
set "port=12345"
set "key=1145141919810"
set "json_file=%library%%txlib_version%/config.json"
set "temp_file=%library%%txlib_version%/temp.json"
"lib\jq.exe" --arg host "!host!" --arg port "!port!" --arg key "!key!" "(.server[] | select(.host == \"replace_host\") | .host) |= \$host | (.server[] | select(.host == \"replace_host\") | .port) |= \$port | (.server[] | select(.host == \"replace_host\") | .key) |= \$key" "%json_file%" > "%temp_file%"
move /y "%temp_file%" "%json_file%"

echo Qsign API:http://%host%:%port%
echo Qsign_version:%ver% TXlib_version:%txlib_version% KEY=%key%

timeout /t 3 > nul
bin\unidbg-fetch-qsign --basePath=%library%%txlib_version%
