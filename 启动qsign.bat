@echo off
set JAVA_HOME=.\jre
set "ver=1.1.3"
set "library=txlib/"
set "txlib_version=8.9.63"
for /F "delims=" %%A in ('lib\jq.exe -r ".server.host" %library%%txlib_version%/config.json') do set "host=%%A"
for /F "delims=" %%B in ('lib\jq.exe -r ".server.port" %library%%txlib_version%/config.json') do set "port=%%B"
for /F "delims=" %%D in ('lib\jq.exe -r ".key" %library%%txlib_version%/config.json') do set "key=%%D"
echo Qsign API:http://%host%:%port%
echo Qsign_version:%ver% TXlib_version:%txlib_version% KEY=%key%


bin\unidbg-fetch-qsign --basePath=%library%%txlib_version%

