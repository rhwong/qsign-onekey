# unidbg-fetch-qsign-onekey

## 一键运行qsign
用于一键在Windows下部署fuqiuluo/unidbg-fetch-qsign

请将该脚本和go-cqhttp放在同一级目录，脚本启动时会自动读取device.json文件中的ANDROID_ID

正确启动后，在需要填写签名服务器的地方填写如下地址

```
http://127.0.0.1:13579
```

如果你需要自定义端口和IP，可以编辑 启动qsign.bat 文件里的变量部分

## Qsign_Monitor

这个powershell脚本用于检测签名服务器是否正常工作，如果检测不到13579端口上有服务，那么就会重新运行 启动qsign.bat
所以如果你自定义了端口，那么需要在这个脚本里也作相应的修改

## 使用方法

推荐您直接右键点击 Qsign_Monitor.ps1 ，选择 使用PowerShell运行，这样在开启监控的同时会启动qsign服务端