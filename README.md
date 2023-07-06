# unidbg-fetch-qsign-onekey

## 一键运行qsign

用于一键在Windows下部署[fuqiuluo/unidbg-fetch-qsign](https://github.com/fuqiuluo/unidbg-fetch-qsign)

本项目使用1.1.0版本，后续版本由于当前go-cqhttp(1.1.0)暂未适配，所以暂不升级。如需新版请移步[dev](https://github.com/rhwong/unidbg-fetch-qsign-onekey/tree/dev)分支。

请将该脚本和 `go-cqhttp` 放在同一级目录，这时脚本会自动读取 `device.json` 文件中的 `ANDROID_ID`

正确启动后，在需要填写签名服务器的地方填写如下地址

```
http://127.0.0.1:13579
```

如果你需要自定义端口和IP，或者你不与 `go-cqhttp` 放在同一个目录下，想要手动修改 `ANDROID_ID`，那么你可以编辑 `启动qsign.bat` 文件里最上方的变量部分

## Qsign_Monitor

这个powershell脚本用于检测签名服务器是否正常工作，如果检测不到13579端口上有服务，那么就会重新运行 `启动qsign.bat`
所以如果你自定义了端口，那么需要在这个脚本里也作相应的修改

## 使用方法

推荐您直接右键点击 `Qsign_Monitor.ps1` ，选择 `使用PowerShell运行`，这样在开启监控的同时会启动qsign服务端
