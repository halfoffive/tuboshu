# host 文件恢复
## 原理
部分设备把特定网站导向了不正确的服务器，通过清空`host`文件，可以消除限制。
## 一行代码
### powershell

在Windows系统中，可以通过一行PowerShell命令实现这些操作：

```powershell
Start-Process PowerShell -Verb RunAs -ArgumentList "Set-Content -Path $env:windir\system32\drivers\etc\hosts -Value '' -Force"
```

**命令说明：**
- `Start-Process PowerShell -Verb RunAs` - 以管理员权限启动PowerShell
- `Set-Content -Path ...\hosts` - 设置hosts文件内容
- `-Value ''` - 设置为空内容（清空文件）
- `-Force` - 强制操作，覆盖只读属性

**执行步骤：**
1. 按 `Win + R` 打开运行对话框
2. 输入 `cmd` 或 `powershell` 打开命令行
3. 粘贴上述命令并执行

**注意事项：**
- 执行时会弹出UAC权限确认窗口，需要点击"是"
- 此操作会完全清空hosts文件，请确保了解后果
- 如果系统有安全软件可能会拦截此操作

### CMD
在CMD中可以使用这一行命令：

```powershell
powershell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList 'Set-Content -Path %windir%\system32\drivers\etc\hosts -Value \"\" -Force'"
```

或者纯CMD版本（需要确认UAC）：

```powershell
echo. > "%windir%\system32\drivers\etc\hosts" && takeown /f "%windir%\system32\drivers\etc\hosts" /a && icacls "%windir%\system32\drivers\etc\hosts" /grant administrators:F && echo. > "%windir%\system32\drivers\etc\hosts"
```

**纯CMD命令分解说明：**
- `echo. > hosts` - 清空文件内容
- `takeown /f hosts /a` - 获取文件所有权给Administrators组
- `icacls hosts /grant administrators:F` - 给管理员组完全控制权限
- 再次 `echo. > hosts` 确保清空

**更简洁的一行CMD命令：**
```powershell
powershell -c "Start-Process cmd -Verb RunAs -ArgumentList '/c echo. > %windir%\system32\drivers\etc\hosts'"
```

**执行方法：**
1. 按 `Win + R` 输入 `cmd` 回车
2. 粘贴上述任意命令执行
3. 在UAC提示中点击"是"


推荐使用PowerShell版本，因为它能更好地处理权限和文件操作。
**验证操作是否成功：**
```powershell
type %windir%\system32\drivers\etc\hosts
```
如果显示空白，说明hosts文件已清空。