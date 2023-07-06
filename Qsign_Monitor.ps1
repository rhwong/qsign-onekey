$url = "http://127.0.0.1:13579"

while ($true) {
    try {
        $request = [System.Net.HttpWebRequest]::Create($url)
        $request.Method = "HEAD"
        $request.Timeout = 5000
        $response = $request.GetResponse()
    } catch [System.Net.WebException] {
        $statusCode = [int]$_.Exception.Response.StatusCode
        
        if ($statusCode -eq 200 -or ($statusCode -ge 400 -and $statusCode -le 405)) {
            Write-Host "Qsign API 状态正常."
        } else {
            Write-Host "检测到Qsign API已离线，正在重启程序..."
            
            # 启动项目(这里替换成你自己的启动脚本或快捷方式路径)
            Start "Start_Qsign.bat"
            
            Write-Host "Qsign服务端已启动！"
        }
    }
    
    # 等待一段时间后继续监测
    Start-Sleep -Seconds 30
}
