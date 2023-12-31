@echo off
chcp 936 > NUL
title Qsign-Onekey 守护进程
setlocal enabledelayedexpansion
set JAVA_HOME=.\jre
set "ver=2024-01-05"
set "library=txlib/"
set "config_file=config.yml"
set "account=1233456"
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
  echo [txlib_version.json] 版本信息文件未找到。
  echo 请输入要设定的选项,按Enter键确认。
  echo 如果你直接按下Enter键，将会保存提示的默认参数。
  echo -------------------------------------------------------------------------------------------------
  set /p "txlib_version=txlib版本(默认:8.9.88): "
       if "!txlib_version!"=="" (
	   set "txlib_version=8.9.88"
       )  
  set "json_file=%library%!txlib_version!/config.json"
  
  set /p "host=主机IP[HOST](默认:127.0.0.1): "
      if "!host!"=="" (
      set "host=127.0.0.1"
      )
  set /p "port=端口[PORT](默认:13579): "
      if "!port!"=="" (
      set "port=13579"
      )
  set /p "key=密钥[KEY](默认:1145141919810): "
      if "!key!"=="" (
      set "key=1145141919810"
      )

if not exist "txlib\!txlib_version!\" (
  echo -------------------------------------------------------------------------------------------------
      echo 警告！错误的 txlib 版本号。
      echo 请检查 "txlib" 文件夹!
      echo 以下是您目前已经安装的 txlib 版本号:
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
  echo txlib 版本号为 %txlib_version%
  echo 如果你想要修改 txlib 版本号 , 请删除 [txlib_version.json] 文件!
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
    echo 没找到go-cqhttp的配置文件 [config.yml]. 如果你忘了生成它，请运行 [go-cqhttp.bat] 
  )
      echo 同步当前 txlib 版本协议文件至go-cqhttp的协议信息目录.
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
  echo 与 go-cqhttp 分离运行?
  echo 请注意手动同步版本协议文件至go-cqhttp的协议信息目录。
  echo 然后输入 Qsign API 地址和 KEY 到对应的客户端中。
)  
  findstr /C:"uin: 1233456" "%config_file%" 2>nul >nul
  if %errorlevel% equ 0 (
      set /p "account=帐号: "
      set /p "password=密码: "
      echo -------------------------------------------------------------------------------------------------
      echo 你的帐号:!account! 密码:!password!
      lib\sed.exe -i "s/uin: 1233456/uin: !account!/g; s/password: ''/password: '!password!'/g; s/auto-refresh-token: false/auto-refresh-token: true/g" "%config_file%"
      echo 帐号和密码信息已保存!
  ) else (
      echo -------------------------------------------------------------------------------------------------
      echo 文件 [config.yml] 中已包含帐户信息或者该文件不存在！
      echo 跳过帐户信息设置。
  )

echo -------------------------------------------------------------------------------------------------
echo Qsign API 地址:http://!host!:!port!
echo 密钥 KEY=!key!
echo Qsign-Onekey版本:%ver%
echo TXlib版本:%txlib_version% 
echo -------------------------------------------------------------------------------------------------
timeout /t 3 > nul

where curl >nul 2>nul
echo 检查系统中是否已安装Curl...
if %errorlevel% equ 0 (
  echo 检测到curl命令，将使用系统变量的curl继续运行。
  set "curl_command=curl"
) else (
  echo 未检测到curl命令，将使用一键包自带的 "curl.exe" 继续运行。此编译仅供x86_64系统使用。
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
    echo Qsign API 存活！
    timeout /t 30 /nobreak >nul
    goto loop
) else (
    echo Qsign API 探活失败，正在结束进程并重新启动...
    if defined pid (
      tasklist /fi "PID eq !pid!" | findstr /i "!pid!" >nul
        if %errorlevel% equ 0 (
          taskkill /F /PID !pid!))
    start "Qsign-Onekey 核心进程" cmd /c "bin\unidbg-fetch-qsign --basePath=%library%%txlib_version%"
    timeout /t 15 /nobreak >nul
    for /f "tokens=5" %%A in ('netstat -ano ^| findstr ":!port!.*LISTENING"') do (
      set "pid=%%A")
    echo Qsign API 运行中 PID:!pid!
    goto loop
)
