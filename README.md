# unidbg-fetch-qsign-onekey

用于一键在Windows下部署fuqiuluo/unidbg-fetch-qsign

请自行修改启动脚本的ANDROID_ID部分。

找到go-cqhttp生成的[device.json]使用记事本打开，按Ctrl+F，搜索ANDROID_ID。

然后你就会看到例如这样的字段："android_id":"c2c672144fab19a4"。

复制其中的值的部分（也就是例子中的c2c672144fab19a4部分，此数值随机生成，请不要照着我的复制）

覆盖粘贴到[启动qsign.bat]文件（使用记事本打开）的末尾处"此处替换你复制来的设备id"。保存后双击运行[启动qsign.bat]

正确的启动脚本应该如下例子所示：

```
set JAVA_HOME=.\zulu-11-jre
bin\unidbg-fetch-qsign --host=127.0.0.1 --port=13579  --count=1 --library=txlib/8.9.63 --android_id=c2c672144fab19a4
```

正确启动后，在需要填写签名服务器的地方填写如下地址

```
http://127.0.0.1:13579
```