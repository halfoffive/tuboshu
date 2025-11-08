@echo off
setlocal enabledelayedexpansion

:: 检查是否以管理员权限运行（通过尝试写入系统目录判断）
copy /y NUL "%SystemRoot%\System32\test_admin.tmp" >nul 2>&1
if errorlevel 1 (
    echo 正在请求管理员权限...
    :: 以管理员权限重新启动脚本
    powershell -Command "Start-Process '%0' -Verb RunAs" >nul 2>&1
    exit /b
) else (
    del /f /q "%SystemRoot%\System32\test_admin.tmp" >nul 2>&1
)

:: 定义hosts文件路径
set "hostsPath=%SystemRoot%\System32\drivers\etc\hosts"

:: 1. 取消只读属性（使用attrib命令）
attrib -r "%hostsPath%" >nul 2>&1
if %errorlevel% equ 0 (
    echo 已取消hosts文件只读属性
) else (
    echo 取消只读属性失败，请手动检查权限
    pause >nul
    exit /b 1
)

:: 2. 清空文件内容（使用echo重定向覆盖）
echo. > "%hostsPath%"
if %errorlevel% equ 0 (
    echo hosts文件内容已清空
) else (
    echo 清空hosts文件失败
    pause >nul
    exit /b 1
)
echo 刷新dns
ipconfig /flushdns

echo 操作完成，按任意键退出...
pause >nul
endlocal