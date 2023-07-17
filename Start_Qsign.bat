@echo off
set JAVA_HOME=.\jre
set "ver=1.1.3"
set "library=txlib/"
set "txlib_version=8.9.63"
set "host=127.0.0.1"
set "port=13579"
set "key=1145141919810"
set "json_file=%library%%txlib_version%/config.json"
set "config_file=config.yml"

if "%txlib_version%"=="8.9.63" (
    echo { "server": { "host": "%host%", "port": %port% }, "key": "%key%", "auto_register": false, "reload_interval": 40, "protocol": { "qua": "V1_AND_SQ_8.9.63_4194_YYB_D", "version": "8.9.63", "code": "4194" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "%json_file%"
)

if "%txlib_version%"=="8.9.68" (
    echo { "server": { "host": "%host%", "port": %port% }, "key": "%key%", "auto_register": false, "reload_interval": 40, "protocol": { "qua": "V1_AND_SQ_8.9.68_4218_HDBM_T", "version": "8.9.68", "code": "4218" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "%json_file%"
)

if "%txlib_version%" neq "8.9.63" (
  if "%txlib_version%" neq "8.9.68" (
    echo 警告: 错误的 txlib_version！请输入正确的协议版本号！
    timeout 10
    exit /b
  )
)

if exist "%config_file%" (
  lib\sed.exe -i "/# sign-server:/d" "%config_file%"
  lib\sed.exe -i "s/sign-server:.*/sign-server: http:\/\/%host%:%port%/g; s/key:.*/key: %key%/g" "%config_file%"
) else (
  echo 当前与go-cqhttp分离运行，请自行修改签名服务器地址及KEY .
)


echo -----------------------------------------------------------
echo Qsign API:http://%host%:%port%
echo KEY=%key%
echo Qsign_version:%ver%
echo TXlib_version:%txlib_version% 
echo -----------------------------------------------------------



timeout /t 3 > nul
bin\unidbg-fetch-qsign --basePath=%library%%txlib_version%
