title pack zip  By QL
@echo off && chcp 65001 && cls
del ./Magisk_CAs_install.zip
7z.exe a -aoa -y -xr!".git" -xr!"README.md" -xr!"others" ./Magisk_CAs_install.zip ../*

echo.
echo.
echo.
echo 10s后自动关闭该窗口
timeout /t 10 >nul
exit /b