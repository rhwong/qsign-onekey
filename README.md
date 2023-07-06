# unidbg-fetch-qsign-onekey

## 一键运行qsign

本分支为开发分支，使用1.1.3版本，由于当前go-cqhttp(1.1.0)暂未适配，所以暂不升级。如需旧版请移步主分支。

用于一键在Windows下部署[fuqiuluo/unidbg-fetch-qsign](https://github.com/fuqiuluo/unidbg-fetch-qsign)

请将该脚本和 `go-cqhttp` 放在同一级目录，这时脚本会自动读取 `config.yml` 文件中的部分参数

如果你需要自定义端口和IP以及协议版本，那么你可以编辑 `Start_Qsign.bat` 文件里最上方的变量部分。

### 新特性

2023-07-07 现在，当与 `config.yml` 同级时，`Start_Qsign.bat` 会自动修改 `config.yml` 中的 `sign-server` 和 `key` 的值，实现了全面懒猪猪启动！

## Qsign_Monitor

这个powershell脚本用于检测签名服务器是否正常工作，如果检测不到13579端口上有服务，那么就会重新运行 `Start_Qsign.bat`
所以如果你自定义了端口，那么需要在这个脚本里也作相应的修改

## 使用方法

推荐您直接右键点击 `Qsign_Monitor.ps1` ，选择 `使用PowerShell运行`，这样在开启监控的同时会启动qsign服务端

