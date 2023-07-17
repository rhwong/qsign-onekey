<div align="center">
    <img alt="OOOK" src="https://olivos.onekey.ren/img/logo.png"/>

# unidbg-fetch-qsign-onekey

注意：本分支为测试分支，使用1.1.5版本，并配合暂未发布的go-cqhttp-1.1.0-fix-sign-server


用于一键在Windows下部署[fuqiuluo/unidbg-fetch-qsign](https://github.com/fuqiuluo/unidbg-fetch-qsign)<br>

<img src="https://img.shields.io/github/issues/rhwong/unidbg-fetch-qsign-onekey"> <img src="https://img.shields.io/github/forks/rhwong/unidbg-fetch-qsign-onekey"> 
<img src="https://img.shields.io/github/stars/rhwong/unidbg-fetch-qsign-onekey"> <img src="https://img.shields.io/github/license/rhwong/unidbg-fetch-qsign-onekey">

注意：本脚本仅适用于Windows x64

<img src="https://img.shields.io/badge/Windows-x86__64-red?style=flat-square&logo=Windows"> 

</div>
<!-- projectInfo end -->

## 安装说明

请将该脚本和 `go-cqhttp` 放在同一级目录，这时脚本会自动读取 `config.yml` 文件中的部分参数。

如果你需要自定义协议版本，那么你可以编辑 `Start_Qsign.bat` 文件里最上方的变量部分。

## 使用方法

推荐您直接右键点击 `Qsign_Monitor.ps1` ，选择 `使用PowerShell运行`，这样在开启监控的同时会启动qsign服务端。

你也可以直接双击 `Start_Qsign.bat` 启动qsign。

如果 `Qsign_Monitor.ps1` 已经是开启状态，请不要重复运行。


## 关于Qsign_Monitor

这个powershell脚本用于检测签名服务器是否正常工作，如果检测不到13579端口上有服务，那么就会重新运行 `Start_Qsign.bat`
所以如果你自定义了端口，那么需要在这个脚本里也作相应的修改


### 新特性

#### 2023-07-07 

现在，当与 `config.yml` 同级时，`Start_Qsign.bat` 会自动修改 `config.yml` 中的 `sign-server` 和 `key` 的值，实现了全面懒猪猪启动！

并且，第一次运行时，会提示你设定`host`、`port`、`key`的值，如果你不想输入，或者不知道怎么输入，请直接按下enter键。

程序默认运行在`8.9.63`版本，如果后续`go-cqhttp`的正式版本中自带的协议有更新，那么本仓库也会同步更新脚本，建议点亮star及时关注哦！

#### 2023-07-18 

更新至1.1.5，新特性请查看原仓库




