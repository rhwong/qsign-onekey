@echo off
title Qsign-Onekey Deamon
setlocal enabledelayedexpansion
set JAVA_HOME=.\jre
set "ver=2024-01-05"
set "library=txlib/"
set "config_file=config.yml"
set "account=rixiang"
set "password="
set "author=rhwong shia kagangtuya-star"

if not exist "txlib_version.json" (
	REM txlib_version_config_file does not exist.
) else ( 
for /F "delims=" %%D in ('lib\jq.exe -r ".txlib_version" txlib_version.json') do set "txlib_version=%%D" 
)
set "json_file=%library%%txlib_version%/config.json"

echo -------------------------------------------------------------------------------------------------
echo * ______  ______  __  ______  __   __       ______  __   __  ______  __  __  ______  __  __    *
echo */\  __ \/\  ___\/\ \/\  ___\/\ \-.\ \     /\  __ \/\ \-.\ \/\  ___\/\ \/ / /\  ___\/\ \_\ \   *
echo *\ \ \/\_\ \___  \ \ \ \ \__ \ \ \-.  \    \ \ \/\ \ \ \-.  \ \  __\\ \  _'-\ \  __\\ \____ \  *
echo * \ \___\_\/\_____\ \_\ \_____\ \_\\ \_\    \ \_____\ \_\\ \_\ \_____\ \_\ \_\ \_____\/\_____\ *
echo *  \/___/_/\/_____/\/_/\/_____/\/_/ \/_/     \/_____/\/_/ \/_/\/_____/\/_/\/_/\/_____/\/_____/ *
echo -------------------------------------------------------------------------------------------------
                                                                                              
if not exist "txlib_version.json" (
  echo -------------------------------------------------------------------------------------------------
  echo unidbg-fetch-qsign-onekey Ver.%ver% by %author%
  echo txlib_version_config_file does not exist.
  echo Please enter an option to save. 
  echo If you press enter directly, save the default values.
  echo -------------------------------------------------------------------------------------------------
  set /p "txlib_version=txlib_version(default:8.9.88): "
       if "!txlib_version!"=="" (
	   set "txlib_version=8.9.88"
       )  
  set "json_file=%library%!txlib_version!/config.json"
  
  set /p "host=host(default:127.0.0.1): "
      if "!host!"=="" (
      set "host=127.0.0.1"
      )
  set /p "port=port(default:8080): "
      if "!port!"=="" (
      set "port=8080"
      )
  set /p "key=key(default:20030901): "
      if "!key!"=="" (
      set "key=20030901"
      )

if not exist "txlib\!txlib_version!\" (
  echo -------------------------------------------------------------------------------------------------
      echo Warning: Wrong txlib_ Version. 
      echo Please check the "txlib" folder!
      echo The following are supported txlib versions:
      dir txlib /b /ad
  echo -------------------------------------------------------------------------------------------------
      timeout 10
      exit /b
  ) else (
      for /F "delims=" %%P in ('lib\jq.exe -r ".protocol.package_name" !json_file!') do set "p_package_name=%%P"
      for /F "delims=" %%Q in ('lib\jq.exe -r ".protocol.qua" !json_file!') do set "p_qua=%%Q"
      for /F "delims=" %%V in ('lib\jq.exe -r ".protocol.version" !json_file!') do set "p_version=%%V"
      for /F "delims=" %%O in ('lib\jq.exe -r ".protocol.code" !json_file!') do set "p_code=%%O"
        echo { "server": { "host": "!host!", "port": !port! }, "share_token": false, "count": 5, "key": "!key!", "auto_register": true, "protocol": { "package_name": "!p_package_name!", "qua": "!p_qua!", "version": "!p_version!", "code": "!p_code!" }, "unidbg": { "dynarmic": false, "unicorn": true, "kvm": false, "debug": false } } > "!json_file!"
        echo {"txlib_version": "!txlib_version!"} > txlib_version.json
  )

) else (   
  for /F "delims=" %%D in ('lib\jq.exe -r ".txlib_version" txlib_version.json') do set "txlib_version=%%D"
  set "json_file=%library%!txlib_version!/config.json"
  echo -------------------------------------------------------------------------------------------------
  echo unidbg-fetch-qsign-onekey Ver.%ver% by %author%
  echo txlib_Version is %txlib_version%
  echo If you want to change txlib_version , please delete [txlib_version.json]!
  echo -------------------------------------------------------------------------------------------------
  for /F "delims=" %%A in ('lib\jq.exe -r ".server.host" %json_file%') do set "host=%%A"
  for /F "delims=" %%B in ('lib\jq.exe -r ".server.port" %json_file%') do set "port=%%B"
  for /F "delims=" %%C in ('lib\jq.exe -r ".key" %json_file%') do set "key=%%C"
)

set "targetPattern=*go-cqhttp*.exe"
set "fileExists=0"

for %%i in (%targetPattern%) do (
    set "fileExists=1"
)

if %fileExists%==1 (
  if exist "%config_file%" (
    lib\sed.exe -i "s/url: 'http:\/\/127.0.0.1:8080'/Example-sign-server/; s/url: 'https:\/\/signserver.example.com'/Example-sign-server/" "%config_file%"
    if "!host!"=="0.0.0.0" (
      lib\sed.exe -i "0,/url: '.*'/s/url: '.*'/url: 'http:\/\/localhost:!port!'/; 0,/key: '.*'/s/key: '.*'/key: '!key!'/" "%config_file%"
      ) else ( 
      lib\sed.exe -i "0,/url: '.*'/s/url: '.*'/url: 'http:\/\/!host!:!port!'/; 0,/key: '.*'/s/key: '.*'/key: '!key!'/" "%config_file%"
      )
  ) else (
    echo Can't find [config.yml]. If you forgot to generate it, please run [go-cqhttp.bat]
  )
      echo Sync protocol version to go-cqhttp data folder.
      md data\versions
      if "!txlib_version!" neq "3.5.1" (
        if "!txlib_version!" neq "3.5.2" (
			if "!txlib_version!" neq "3.5.5" (
				if "!txlib_version!" neq "5.8.2" (
      copy txlib\!txlib_version!\android_pad.json data\versions\6.json
      copy txlib\!txlib_version!\android_phone.json data\versions\1.json
				)
			)
        )
      )
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

where curl >nul 2>nul
echo Check if the curl command is installed in the environment variables...
if %errorlevel% equ 0 (
  echo The curl command is detected, use the installed curl
  set "curl_command=curl"
) else (
  echo The curl command is not detected, use the "curl.exe" from the lib folder.This precompiled executable works only on x86 architecture systems.
  set "curl_command=lib\curl.exe"
)

:loop
if "!host!"=="0.0.0.0" (
       set "core_host=localhost"
      ) else ( 
      set "core_host=!host!"
      )
%curl_command% -I http://!core_host!:!port!/register?uin=12345678 --connect-timeout 5 -m 5 >nul 2>nul
if %errorlevel% equ 0 (
    echo Qsign API is running.
    timeout /t 30 /nobreak >nul
    goto loop
) else (
    echo Qsign API is not running, Restarting...
    if defined pid (
      tasklist /fi "PID eq !pid!" | findstr /i "!pid!" >nul
        if %errorlevel% equ 0 (
          taskkill /F /PID !pid!))
    start "Qsign-Onekey Core" cmd /c "bin\unidbg-fetch-qsign --basePath=%library%%txlib_version%"
    timeout /t 15 /nobreak >nul
    for /f "tokens=5" %%A in ('netstat -ano ^| findstr ":!port!.*LISTENING"') do (
      set "pid=%%A")
    echo Qsign API running on processes with PID:!pid!.
    goto loop
)
