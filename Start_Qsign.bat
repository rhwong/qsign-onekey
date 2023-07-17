@echo off
setlocal enabledelayedexpansion
set JAVA_HOME=.\jre
set "ver=1.1.3"
set "library=txlib/"
set "txlib_version=8.9.63"
set "json_file=%library%%txlib_version%/config.json"
set "config_file=config.yml"
set "account=1233456"
set "password="

if not exist "%json_file%" (
  echo ---------------------------------------------------------------
  echo Default txlib_ Version is %txlib_version%
  echo If you want to change it, please write it to this bat file.
  echo txlib_version_config_file does not exist.
  echo Please enter an option to save. 
  echo If you press enter directly, save the default values.
  echo ---------------------------------------------------------------
  REM set /p "txlib_version=txlib_version(default:8.9.63 optional:8.9.68): "
  REM     if "!txlib_version!"=="" (
  REM     set "txlib_version=8.9.63"
  REM     )
  set /p "host=host(default:127.0.0.1): "
      if "!host!"=="" (
      set "host=127.0.0.1"
      )
  set /p "port=port(default:13579): "
      if "!port!"=="" (
      set "port=13579"
      )
  set /p "key=key(default:1145141919810): "
      if "!key!"=="" (
      set "key=1145141919810"
      )
if "%txlib_version%"=="8.9.63" (
    echo { "server": { "host": "%host%", "port": %port% }, "key": "%key%", "auto_register": false, "reload_interval": 40, "protocol": { "qua": "V1_AND_SQ_8.9.63_4194_YYB_D", "version": "8.9.63", "code": "4194" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "%json_file%"
)

if "%txlib_version%"=="8.9.68" (
    echo { "server": { "host": "%host%", "port": %port% }, "key": "%key%", "auto_register": false, "reload_interval": 40, "protocol": { "qua": "V1_AND_SQ_8.9.68_4218_HDBM_T", "version": "8.9.68", "code": "4218" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "%json_file%"
)
  if "%txlib_version%" neq "8.9.63" (
      if "%txlib_version%" neq "8.9.68" (
        echo Warning: Wrong txlib_ Version. Please enter the correct protocol version number!
        timeout 10
        exit /b
      )
    )
) else (
  echo ---------------------------------------------------------------
  echo txlib_version_config_file exists. 
  echo If you want to rewrite the config.json , please delete it!
  echo ---------------------------------------------------------------
  for /F "delims=" %%A in ('lib\jq.exe -r ".server.host" %json_file%') do set "host=%%A"
  for /F "delims=" %%B in ('lib\jq.exe -r ".server.port" %json_file%') do set "port=%%B"
  for /F "delims=" %%C in ('lib\jq.exe -r ".key" %json_file%') do set "key=%%C"
)


if exist "%config_file%" (
  lib\sed.exe -i "/# sign-server:/d" "%config_file%"
  lib\sed.exe -i "s/sign-server:.*/sign-server: http:\/\/!host!:!port!/g; s/key:.*/key: !key!/g" "%config_file%"
) else (
  echo Run separately from go-cqhttp. Please enter the sign-server address and KEY in go-cqhttp config.
)

findstr /C:"uin: 1233456" "%config_file%" 2>nul >nul
if %errorlevel% equ 0 (
    set /p "account=Account uin: "
    set /p "password=Password: "
    echo Your uin:!account! password:!password!
    lib\sed.exe -i "s/uin: 1233456/uin: !account!/g; s/password: ''/password: '!password!'/g" "%config_file%"
    echo Account and password saved!
) else (
    echo The config file already contains account information.
)

echo ---------------------------------------------------------------
echo Qsign API:http://!host!:!port!
echo KEY=!key!
echo Qsign_version:%ver%
echo TXlib_version:%txlib_version% 
echo ---------------------------------------------------------------
timeout /t 3 > nul
bin\unidbg-fetch-qsign --basePath=%library%%txlib_version%