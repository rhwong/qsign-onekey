@echo off
title go-cqhttp-dev
setlocal enabledelayedexpansion
if not exist "txlib_version.json" (
	REM txlib_version_config_file does not exist.
) else ( 
for /F "delims=" %%D in ('lib\jq.exe -r ".txlib_version" txlib_version.json') do set "txlib_version=%%D" 
)
if "!txlib_version!"=="8.9.71" (
    echo The protocol[8.9.71] just support ANDROID_PHONE now!!!!! Auto changed device.json - protocol=1
    lib\sed.exe -i "s/\"protocol\":6/\"protocol\":1/g" "device.json"
    
)

go-cqhttp.exe -faststart
