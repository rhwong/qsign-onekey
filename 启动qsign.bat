@echo off
set JAVA_HOME=.\jre
set "textFile=device.json"
set "ver=1.1.0"
set "host=127.0.0.1"
set "port=13579"
set "count=1"
set "library=txlib/"
set "txlib_version=8.9.63"
for /F "delims=" %%A in ('lib\jq.exe -r ".android_id" device.json') do set "android_id=%%A"
echo Qsign API:http://%host%:%port%
echo Qsign_version:%ver% TXlib_version:%txlib_version% Android_id=%android_id%


bin\unidbg-fetch-qsign --host=%host% --port=%port%  --count=%count% --library=%library%%txlib_version% --android_id=%android_id%

