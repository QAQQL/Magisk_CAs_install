title pem to .0  By QL
@echo off && setlocal enabledelayedexpansion && chcp 65001 && cls

echo.
echo.
echo =========================================
echo 拖动pem文件到该bat上,转换为对应的.0文件
echo 需要OpenSSL环境
echo =========================================
echo.
echo.


rem 检查输入参数是否为空
if "%1"=="" (
    echo [31m！请拖入要处理的PEM文件！[0m
    timeout /t 3 >nul
    exit /b
)

rem 检查 OpenSSL 是否可用
where openssl >nul 2>nul
if %errorlevel% neq 0 (
    echo [31m！OpenSSL 未安装或不可用！[0m
    timeout /t 3 >nul
    exit /b
)


cls
rem 获取 OpenSSL 版本信息
for /f "tokens=2 delims= " %%v in ('openssl version') do set OPENSSL_VERSION=%%v

rem 提取主要版本号和次要版本号
for /f "tokens=1 delims=." %%a in ("%OPENSSL_VERSION%") do set MAJOR_VERSION=%%a
for /f "tokens=2 delims=." %%b in ("%OPENSSL_VERSION%") do set MINOR_VERSION=%%b

rem 将版本号转换为整数
set /a VERSION_NUMBER=%MAJOR_VERSION%*100+%MINOR_VERSION%*10

rem 判断 OpenSSL 版本是否大于等于 1.0
if %VERSION_NUMBER% geq 100 (
    echo %VERSION_NUMBER%  大于1.0版本
    openssl x509 -inform PEM -subject_hash_old -in %1 > output.txt
) else (
    echo %VERSION_NUMBER%  小于1.0版本
    openssl x509 -inform PEM -subject_hash -in %1 > output.txt
)

rem 如果 OpenSSL 版本符合要求,则提取输出中的第一行哈希文本
if exist output.txt (
    for /f "usebackq tokens=1" %%h in ("output.txt") do (
        if not defined HASH set "HASH=%%h"
    )
    del output.txt
)

if "%HASH%"=="" (
    echo [31m！无法生成正确hash,请检查文件！[0m
    timeout /t 3 >nul
    exit /b
)


rem 复制拖入的文件到 ..\system\etc\security\cacerts\hash.0 文件夹
@copy /Y %1 %~dp0..\system\etc\security\cacerts\%HASH%.0


cls
set MESSAGE=已将 %~n1 转为 !HASH!.0 存储到模块中，请 zip 后安装模块
echo %MESSAGE%
echo 10s后自动关闭该窗口
timeout /t 10 >nul
exit /b