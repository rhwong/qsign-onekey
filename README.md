<div align="center">
    <img alt="OOOK" src="https://olivos.onekey.ren/img/logo.png"/>

# unidbg-fetch-qsign-onekey


本项目使用1.1.6版本，由于当前go-cqhttp(1.1.0)暂未适配，内置了[非官方编译版本的go-cqhttp](https://github.com/rhwong/go-cqhttp-dev/tree/dev)。



用于一键在Windows下部署[fuqiuluo/unidbg-fetch-qsign](https://github.com/fuqiuluo/unidbg-fetch-qsign)<br>

<img src="https://img.shields.io/github/issues/rhwong/unidbg-fetch-qsign-onekey"> <img src="https://img.shields.io/github/forks/rhwong/unidbg-fetch-qsign-onekey"> 
<img src="https://img.shields.io/github/stars/rhwong/unidbg-fetch-qsign-onekey"> <img src="https://img.shields.io/github/license/rhwong/unidbg-fetch-qsign-onekey">

注意：本一键包仅适用于Windows

<img src="https://img.shields.io/badge/Windows-red?style=flat-square&logo=Windows"> 

</div>
<!-- projectInfo end -->

## 安装说明

请将该脚本和 `go-cqhttp` 放在同一级目录，这时脚本会自动读取 `config.yml` 文件中的部分参数。

建议存放在不包含空格、中文的文件夹路径中。

## 使用方法

首先，运行 `go-cqhttp.bat`，按照提示生成 `config.yml` 。

双击 `Start_Qsign.bat` 启动qsign，按照提示依次键入 `txlib_version` 参数、设定`host`、`port`、`key`的值。（如果不知道这些是干什么的，请直接依次按下Enter）

如果脚本检测到 `config.yml` 尚未设定账号和密码，那么会提示你输入账号(Account uin)和密码(password)，输入后会同步进 `config.yml` 。

如果日后需要修改 `txlib_version` 的版本以及其他参数，您可以删除文件夹根目录下的 `txlib_version.json` 来重新进入设定流程，也可以对此文件进行修改。

## 关于Qsign_Monitor

~~推荐您直接右键点击 `Qsign_Monitor.ps1` ，选择 `使用PowerShell运行`，这样在开启监控的同时会启动qsign服务端。~~

~~这个powershell脚本用于检测签名服务器是否正常工作，如果检测不到13579端口上有服务，那么就会重新运行 `Start_Qsign.bat`~~
~~所以如果你自定义了端口，那么需要在这个脚本里也作相应的修改~~

这个脚本目前不能很好的运行，所以请暂时不要使用。(issues#3)


### 新特性

#### 2023-07-07 

更新至1.1.3版本

现在，当与 `config.yml` 同级时，`Start_Qsign.bat` 会自动修改 `config.yml` 中的 `sign-server` 和 `key` 的值，实现了全面懒猪猪启动！

并且，第一次运行时，会提示你设定`host`、`port`、`key`的值，如果你不想输入，或者不知道怎么输入，请直接按下enter键。

程序默认运行在`8.9.63`版本，如果后续`go-cqhttp`的正式版本中自带的协议有更新，那么本仓库也会同步更新脚本，建议点亮star及时关注哦！

#### 2023-07-18 

更新至1.1.5，新特性请查看原仓库

#### 2023-07-20

更新至1.1.6，新增特性如下：

启动时新增txlib_version参数，用于设定你所需要的txlib_version版本号。

选项有`8.9.63`(默认)/`8.9.68`/`8.9.70`

对于`go-cqhttp`的`dev`版本，目前仍是`8.9.63`，所以此处默认是`8.9.63`。

如果你是其他客户端，比如`icqq`默认是`8.9.68`，请自行输入修改此项。
