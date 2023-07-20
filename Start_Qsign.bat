@echo off
setlocal enabledelayedexpansion
set JAVA_HOME=.\jre
set "ver=1.1.6"
set "library=txlib/"
set "config_file=config.yml"
set "account=1233456"
set "password="
if not exist "txlib_version.json" (
	REM txlib_version_config_file does not exist.
) else ( 
for /F "delims=" %%D in ('lib\jq.exe -r ".txlib_version" txlib_version.json') do set "txlib_version=%%D" 
)

set "json_file=%library%%txlib_version%/config.json"

if not exist "txlib_version.json" (
  echo ---------------------------------------------------------------
  echo unidbg-fetch-qsign-onekey Ver.%ver%
  echo txlib_version_config_file does not exist.
  echo Please enter an option to save. 
  echo If you press enter directly, save the default values.
  echo ---------------------------------------------------------------
  set /p "txlib_version=txlib_version(optional:8.9.63(default)/8.9.68/8.9.70): "
       if "!txlib_version!"=="" (
	   set "txlib_version=8.9.63"
       )  
  set "json_file=%library%!txlib_version!/config.json"
  
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
  if "!txlib_version!"=="8.9.63" (
    echo { "server": { "host": "!host!", "port": !port! }, "key": "!key!", "auto_register": true, "protocol": { "qua": "V1_AND_SQ_8.9.63_4194_YYB_D", "version": "8.9.63", "code": "4194" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "!json_file!"
	echo {"txlib_version": "8.9.63"} > txlib_version.json
	)

  if "!txlib_version!"=="8.9.68" (
REM OLD_PROTOCOL WHO KNOW WHATS THIS?
REM echo { "server": { "host": "!host!", "port": !port! }, "key": "!key!", "auto_register": true, "protocol": { "qua": "V1_AND_SQ_8.9.68_4218_HDBM_T", "version": "8.9.68", "code": "4218" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "!json_file!"
	echo { "server": { "host": "!host!", "port": !port! }, "key": "!key!", "auto_register": true, "protocol": { "qua": "V1_AND_SQ_8.9.68_4264_YYB_D", "version": "8.9.68", "code": "4264" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "!json_file!"
	echo {"txlib_version": "8.9.68"} > txlib_version.json
    )
	
  if "!txlib_version!"=="8.9.70" (
    echo { "server": { "host": "!host!", "port": !port! }, "key": "!key!", "auto_register": true, "protocol": { "qua": "V1_AND_SQ_8.9.70_4292_HDBM_T", "version": "8.9.70", "code": "4292" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "!json_file!"
	echo {"txlib_version": "8.9.70"} > txlib_version.json
	)
	
  if "!txlib_version!" neq "8.9.63" (
      if "!txlib_version!" neq "8.9.68" (
		 if "!txlib_version!" neq "8.9.70" (
			echo Warning: Wrong txlib_ Version. The protocol must be 8.9.63/8.9.68/8.9.70
			timeout 10
			exit /b
		)
      )
    )
) else (   
  for /F "delims=" %%D in ('lib\jq.exe -r ".txlib_version" txlib_version.json') do set "txlib_version=%%D"
  set "json_file=%library%!txlib_version!/config.json"
  echo ---------------------------------------------------------------
  echo unidbg-fetch-qsign-onekey Ver.%ver%
  echo txlib_Version is %txlib_version%
  echo If you want to change txlib_version , please delete [txlib_version.json]!
  echo ---------------------------------------------------------------
  for /F "delims=" %%A in ('lib\jq.exe -r ".server.host" %json_file%') do set "host=%%A"
  for /F "delims=" %%B in ('lib\jq.exe -r ".server.port" %json_file%') do set "port=%%B"
  for /F "delims=" %%C in ('lib\jq.exe -r ".key" %json_file%') do set "key=%%C"
)


if exist "%config_file%" (
  lib\sed.exe -i "/# sign-server:/d" "%config_file%"
  lib\sed.exe -i "s/sign-server:.*/sign-server: 'http:\/\/!host!:!port!'/g; s/key:.*/key: '!key!'/g" "%config_file%"
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