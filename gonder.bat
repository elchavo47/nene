@echo off
chcp 65001 >nul
cd /d C:\nene-ios
echo === Nene: GitHub'a parca parca gonderim ===
if exist .git rmdir /s /q .git
del /q cd 2>nul
git init -q
git branch -M main
git remote add origin https://github.com/elchavo47/nene.git
git config http.postBuffer 1048576000
git config http.version HTTP/1.1
git config http.lowSpeedLimit 0
git config http.lowSpeedTime 999999

call :adim 1 "kucuk dosyalar" .github .gitattributes nene-ikon-1024.png gonder.bat hazirla.bat hazirla.ps1 BENIOKU.txt Info.plist LaunchScreen-* *.sh usymtool usymtoolarm64 MainApp "Unity-iPhone" "Unity-iPhone Tests" Unity-iPhone.xcodeproj UnityFramework Frameworks
call :adim 2 "Classes" Classes
call :adim 3 "Il2Cpp" Il2CppOutputProject
for %%p in (Libraries\libiPhone-lib.a.part*) do call :adim L "%%~nxp" "%%p"
call :adim 4 "Libraries geri kalan" Libraries
for %%p in (Data\resources.assets.part*) do call :adim D "%%~nxp" "%%p"
call :adim 5 "Data geri kalan" Data
call :adim 6 "kalanlar" .
echo.
echo === BITTI. GitHub'da Actions sekmesine bak. Son is yesil olmali (oncekiler kirmizi olabilir, onemli degil). ===
pause
exit /b

:adim
set N=%~1
set AD=%~2
shift & shift
set LISTE=
:topla
if "%~1"=="" goto ekle
set LISTE=%LISTE% "%~1"
shift
goto topla
:ekle
echo.
echo --- Adim %N%: %AD% ---
git add -A -- %LISTE% 2>nul
git diff --cached --quiet && (echo   eklenecek yok, geciliyor & exit /b)
git commit -q -m "Nene iOS parca %N%: %AD%"
set /a DENEME=0
:tekrar
set /a DENEME+=1
git push -u origin main --force && (echo   TAMAM & exit /b)
if %DENEME% GEQ 5 (echo   5 denemede olmadi. Interneti kontrol edip gonder.bat'i tekrar calistir. & pause & exit)
echo   Baglanti koptu, 10 sn sonra tekrar deneniyor (%DENEME%/5)...
timeout /t 10 >nul
goto tekrar
