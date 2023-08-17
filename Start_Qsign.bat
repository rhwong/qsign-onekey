@echo off
title Qsign-Onekey by rhwong v1.1.7-b2
setlocal enabledelayedexpansion
set JAVA_HOME=.\jre
set "ver=1.1.7b2"
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

echo " ______  ______  __  ______  __   __       ______  __   __  ______  __  __  ______  __  __    "
echo "/\  __ \/\  ___\/\ \/\  ___\/\ \-.\ \     /\  __ \/\ \-.\ \/\  ___\/\ \/ / /\  ___\/\ \_\ \   "
echo "\ \ \/\_\ \___  \ \ \ \ \__ \ \ \-.  \    \ \ \/\ \ \ \-.  \ \  __\\ \  _'-\ \  __\\ \____ \  "
echo " \ \___\_\/\_____\ \_\ \_____\ \_\\ \_\    \ \_____\ \_\\ \_\ \_____\ \_\ \_\ \_____\/\_____\ "
echo "  \/___/_/\/_____/\/_/\/_____/\/_/ \/_/     \/_____/\/_/ \/_/\/_____/\/_/\/_/\/_____/\/_____/ "
                                                                                              
if not exist "txlib_version.json" (
  echo -------------------------------------------------------------------------------------------------
  echo unidbg-fetch-qsign-onekey Ver.%ver%
  echo txlib_version_config_file does not exist.
  echo Please enter an option to save. 
  echo If you press enter directly, save the default values.
  echo -------------------------------------------------------------------------------------------------
  set /p "txlib_version=txlib_version(optional:8.9.58/8.9.63(default)/8.9.68/8.9.70): "
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

  if "!txlib_version!"=="8.9.58" (
    echo { "server": { "host": "!host!", "port": !port! }, "key": "!key!", "auto_register": true, "protocol": { "qua": "V1_AND_SQ_8.9.58_4106_YYB_D", "version": "8.9.58", "code": "4106" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "!json_file!"
	  echo {"txlib_version": "8.9.58"} > txlib_version.json
	)

  if "!txlib_version!"=="8.9.63" (
    echo { "server": { "host": "!host!", "port": !port! }, "key": "!key!", "auto_register": true, "protocol": { "qua": "V1_AND_SQ_8.9.63_4194_YYB_D", "version": "8.9.63", "code": "4194" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "!json_file!"
	  echo {"txlib_version": "8.9.63"} > txlib_version.json
	)

  if "!txlib_version!"=="8.9.68" (
	  echo { "server": { "host": "!host!", "port": !port! }, "key": "!key!", "auto_register": true, "protocol": { "qua": "V1_AND_SQ_8.9.68_4264_YYB_D", "version": "8.9.68", "code": "4264" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "!json_file!"
	  echo {"txlib_version": "8.9.68"} > txlib_version.json
    )
	
  if "!txlib_version!"=="8.9.70" (
    echo { "server": { "host": "!host!", "port": !port! }, "key": "!key!", "auto_register": true, "protocol": { "qua": "V1_AND_SQ_8.9.70_4330_YYB_D", "version": "8.9.70", "code": "4330" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "!json_file!"
	  echo {"txlib_version": "8.9.70"} > txlib_version.json
	)
	

REM  if "!txlib_version!"=="8.9.73" (
REM    echo { "server": { "host": "!host!", "port": !port! }, "key": "!key!", "auto_register": true, "protocol": { "qua": "V1_AND_SQ_8.9.73_4416_YYB_D", "version": "8.9.73", "code": "4416" }, "unidbg": { "dynarmic": false, "unicorn": true, "debug": false } } > "!json_file!"
REM	  echo {"txlib_version": "8.9.73"} > txlib_version.json
REM	)

  if "!txlib_version!" neq "8.9.58" (
    if "!txlib_version!" neq "8.9.63" (
        if "!txlib_version!" neq "8.9.68" (
          if "!txlib_version!" neq "8.9.70" (
            if "!txlib_version!" neq "8.9.73" (
            echo Warning: Wrong txlib_ Version. The protocol must be 8.9.58/8.9.63/8.9.68/8.9.70/8.9.73
            timeout 10
            exit /b
            )
          )
        )
      )
  )
) else (   
  for /F "delims=" %%D in ('lib\jq.exe -r ".txlib_version" txlib_version.json') do set "txlib_version=%%D"
  set "json_file=%library%!txlib_version!/config.json"
  echo -------------------------------------------------------------------------------------------------
  echo unidbg-fetch-qsign-onekey Ver.%ver%
  echo txlib_Version is %txlib_version%
  echo If you want to change txlib_version , please delete [txlib_version.json]!
  echo -------------------------------------------------------------------------------------------------
  for /F "delims=" %%A in ('lib\jq.exe -r ".server.host" %json_file%') do set "host=%%A"
  for /F "delims=" %%B in ('lib\jq.exe -r ".server.port" %json_file%') do set "port=%%B"
  for /F "delims=" %%C in ('lib\jq.exe -r ".key" %json_file%') do set "key=%%C"
)

if exist "go-cqhttp.exe" (
  if exist "%config_file%" (
    lib\sed.exe -i "/# sign-server:/d" "%config_file%"
    if "!host!"=="0.0.0.0" (
      lib\sed.exe -i "s/sign-server:.*/sign-server: 'http:\/\/localhost:!port!'/g; s/key:.*/key: '!key!'/g" "%config_file%"
      ) else ( 
      lib\sed.exe -i "s/sign-server:.*/sign-server: 'http:\/\/!host!:!port!'/g; s/key:.*/key: '!key!'/g" "%config_file%"
      )
  ) else (
    echo Can't find [config.yml]. If you forgot to generate it, please run [go-cqhttp.bat]
  )
      echo Sync protocol version to go-cqhttp data folder.
      md data\versions
      copy txlib\!txlib_version!\android_pad.json data\versions\6.json
      copy txlib\!txlib_version!\android_phone.json data\versions\1.json
) else (
  echo Run separately from go-cqhttp?
  echo Please manually synchronize the protocol version.
  echo And enter the Qsign API ADDRESS and KEY to other client.
)  
  findstr /C:"uin: 1233456" "%config_file%" 2>nul >nul
  if %errorlevel% equ 0 (
      set /p "account=Account uin: "
      set /p "password=Password: "
      echo -------------------------------------------------------------------------------------------------
      echo Your uin:!account! password:!password!
      lib\sed.exe -i "s/uin: 1233456/uin: !account!/g; s/password: ''/password: '!password!'/g; s/auto-refresh-token: false/auto-refresh-token: true/g" "%config_file%"
      echo Account and password saved!
  ) else (
      echo -------------------------------------------------------------------------------------------------
      echo The [config.yml] already contains account information or not exist.
      echo Skip account settings.
  )

echo -------------------------------------------------------------------------------------------------
echo Qsign API:http://!host!:!port!
echo KEY=!key!
echo Qsign_version:%ver%
echo TXlib_version:%txlib_version% 
echo -------------------------------------------------------------------------------------------------
timeout /t 3 > nul
bin\unidbg-fetch-qsign --basePath=%library%%txlib_version%
