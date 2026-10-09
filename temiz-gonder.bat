@echo off
chcp 65001 >nul
cd /d C:\nene-ios
echo === Nene: temiz gonderim (LFS kapatiliyor, buyuk dosyalar bolunuyor) ===
git lfs uninstall >nul 2>&1
> .gitattributes echo * -text
del /q kuz.bat 2>nul
if not exist hazirla.ps1 ( echo hazirla.ps1 yok! nene-ios-yukle.zip icindekileri C:\nene-ios icine kopyala. & pause & exit /b )
if not exist gonder.bat ( echo gonder.bat yok! C:\nene-ios icine koy. & pause & exit /b )
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0hazirla.ps1"
call gonder.bat
