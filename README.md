<div align="center">
    <img alt="OOOK" src="https://olivos.onekey.ren/img/logo.png"/>

# unidbg-fetch-qsign-onekey

本项目使用1.1.7版本，由于当前go-cqhttp(1.1.0)暂未适配，请来[此repo下载](https://github.com/rhwong/go-cqhttp-dev/releases/tag/v1.1.1-dev)非官方编译版本。如需旧版请移步release


用于一键在Windows下部署[fuqiuluo/unidbg-fetch-qsign](https://github.com/fuqiuluo/unidbg-fetch-qsign)<br>

<img src="https://img.shields.io/github/issues/rhwong/unidbg-fetch-qsign-onekey"> <img src="https://img.shields.io/github/forks/rhwong/unidbg-fetch-qsign-onekey"> 
<img src="https://img.shields.io/github/stars/rhwong/unidbg-fetch-qsign-onekey"> <img src="https://img.shields.io/github/license/rhwong/unidbg-fetch-qsign-onekey">
<img src="https://img.shields.io/github/downloads/rhwong/unidbg-fetch-qsign-onekey/total">

注意：本一键包推荐使用于Windows Server 2016 ~ 2022(21H2)

<img src="https://img.shields.io/badge/Windows-x64-red?style=flat-square&logo=Windows"> <img src="https://img.shields.io/badge/Windows-x86-red?style=flat-square&logo=Windows"> 

</div>
<!-- projectInfo end -->

## ✨安装说明

请直接点击 `Code - Download ZIP` 下载本项目，(当前release里是用于正式版本go-cqhttp的旧版本qsign)

请将本项目和 `go-cqhttp` 放在同一级目录，这时脚本会自动读取 `config.yml` 文件中的部分参数。

如果你需要对接其他登录端，可以直接解压缩到任意不包含中文和空格的路径中。

已知问题：

对于最新的11内核的Windows Server版本，出现了严重兼容性问题，

具体表现为对接go-cqhttp时出现各种报错，原因未知。（并非是本脚本问题）

建议购买云服务器时不要选择Windows Server 2022

## ✨使用方法

### 如何使用go-cqhttp联动运行

1. 首先，运行 `go-cqhttp.bat`，按照提示生成 `config.yml` 。(👈如果放在同一个目录下运行，独立运行略过此步骤）

2. 双击 `Start_Qsign.bat` 启动qsign，按照提示依次键入 `txlib_version` 参数、设定`host`、`port`、`key`的值。 (👈如果不知道这些是干什么的，请直接依次按下Enter）

3. 在启动完成后，qsign会告诉您当前运行api的地址，如果您没设定过host和key，那么默认是 `http://127.0.0.1:13579`。key已经在开始时设定过，如果您没设定，那么默认是 `1145141919810`。请将这两个参数填写到需要设定账号的签名服务器的地方。

4. 如果脚本检测到 `config.yml` 尚未设定账号和密码，那么会提示你输入账号(Account uin)和密码(password)，输入后会同步进 `config.yml` 。

5. 如果日后需要修改 `txlib_version` 的版本，您可以删除文件夹根目录下的 `txlib_version.json` 来重新进入设定流程，也可以对此文件进行修改。

### 如何独立运行

参考上方，略过部分go-cqhttp相关步骤。

## 🌏分享您的Qsign API

您可以在 [这里](https://github.com/rhwong/unidbg-fetch-qsign-onekey/issues/8) 分享您的Qsign API以供其他设备性能较弱，或不适用于unidbg的设备测试及使用。

请注意，由于程序性能限制，并发需要您有更多的CPU核心，计算时间基于您的单核心性能。不推荐低性能服务器进行分享。

我们在 [这里](https://qsign.dev) 分享公益的Qsign API列表，但是请使用者注意，我们不建议也不推荐您长期使用公益API。

这是基于签名服务原理和特殊性的建议，我们仅推荐您在自建API无法正确使用，或测试时使用该列表内的Qsign API。

注意: 使用他人搭建的服务可能会泄露以下信息

| 可能会泄露以下信息          | 不会泄露的信息: |
| --------------------------- | --------------- |
| 登录账号                    | 账号密码        |
| 登录时间                    | 账号 `session`  |
| 登录后发送的消息内容        | 群列表/好友列表 |
| 登录后发送消息的群号/好友ID | 接收的消息      |
|  | 除发送消息外的任何历史记录      |

## ❌关于Qsign_Monitor

~~推荐您直接右键点击 `Qsign_Monitor.ps1` ，选择 `使用PowerShell运行`，这样在开启监控的同时会启动qsign服务端。~~

~~这个powershell脚本用于检测签名服务器是否正常工作，如果检测不到13579端口上有服务，那么就会重新运行 `Start_Qsign.bat`~~
~~所以如果你自定义了端口，那么需要在这个脚本里也作相应的修改~~

这个脚本目前不能很好的运行，所以请暂时不要使用。(issues#3)


## 📢新特性

#### 📅2023-07-07 

更新至1.1.3版本

- 现在，当与 `config.yml` 同级时，`Start_Qsign.bat` 会自动修改 `config.yml` 中的 `sign-server` 和 `key` 的值，实现了全面懒猪猪启动！

并且，第一次运行时，会提示你设定`host`、`port`、`key`的值，如果你不想输入，或者不知道怎么输入，请直接按下enter键。

- 程序默认运行在`8.9.63`版本，如果后续`go-cqhttp`的正式版本中自带的协议有更新，那么本仓库也会同步更新脚本，建议点亮star及时关注哦！

#### 📅2023-07-18 

- 更新至1.1.5，新特性请查看原仓库

#### 📅2023-07-20

- 更新至1.1.6，新增特性如下：

  启动时新增txlib_version参数，用于设定你所需要的txlib_version版本号。

  选项有`8.9.63`(默认)/`8.9.68`/`8.9.70`

  对于`go-cqhttp`的`dev`版本，目前仍是`8.9.63`，所以此处默认是`8.9.63`。

  如果你是其他客户端，比如`icqq`默认是`8.9.68`，请自行输入修改此项。

#### 📅2023-07-27

- 更新至1.1.7，新特性请查看原仓库

#### 📅2023-07-30

support:txlib_8.9.58

- 偷了几个`android_pad.json` `android_phone.json`回来，方便客户端与签名服务端的协议信息相匹配。[MrXiaoM/qsign](https://github.com/MrXiaoM/qsign)

- 拉取了fix版本的1.1.7（我还真没发现后面有fix，好像当前版本会崩溃，不知道fix版本修复没修复鸭）fuqiuluo/unidbg-fetch-qsign#164

- 🎉另外祝我生日快乐~🥰🎂

## ✨免责声明

- 本仓库所有关于qsign签名服务的二进制文件均来自于[fuqiuluo/unidbg-fetch-qsign](https://github.com/fuqiuluo/unidbg-fetch-qsign)

- 本仓库所使用的关于go-cqhttp与qsign版本不适配期间所代用的非官方版本go-cqhttp，均来自于自己或其他人的action/release，并且会注明来源。

- 本仓库所有二进制文件您都可以根据SHA1校验其与官方仓库的二进制文件的一致性，本人现在及将来均不会对此仓库所有分支的二进制文件所有(可能发生的)安全问题负责。
