@echo off
setlocal enabledelayedexpansion

:: set directory
set SEARCH_DIR=%USERPROFILE%
for /r "%SEARCH_DIR%" %%d in (.) do (
    if /i "%%~nd"=="waifuu" (
        set ASCII_DIR=%%d
        goto :found
    )
)

echo No directory found.
exit /b

:found
:: collect txts
set COUNT=0
for %%f in (%ASCII_DIR%\*.txt) do (
    set /a COUNT+=1
    set FILE[!COUNT!]=%%f
)

if %COUNT%==0 (
    echo No ASCII art files found in "%ASCII_DIR%".
    exit /b
)

:: random file selection
set /a RANDOM=%RANDOM%%%COUNT+1
set RANDOM_FILE=!FILE[%RANDOM%]!

:: fetch sys infos
for /f "tokens=2 delims==" %%a in ('wmic os get caption /value') do set OS=%%a
for /f "tokens=2 delims==" %%a in ('wmic os get buildnumber /value') do set KERNEL=%%a
for /f "tokens=2 delims==" %%a in ('wmic cpu get caption /value') do set CPU=%%a
for /f "tokens=2 delims==" %%a in ('wmic os get freephysicalmemory /value') do set MEMORY=%%a
for /f "tokens=2 delims==" %%a in ('wmic os get lastbootuptime /value') do set UPTIME=%%a

:: show files
cls
type "!RANDOM_FILE!"

:: Show sys infos
echo.
echo %USERNAME%@%COMPUTERNAME%
echo ----------------------
echo OS: %OS%
echo Kernel: %KERNEL%
echo Uptime: %UPTIME%
echo CPU: %CPU%
echo Memory: %MEMORY% KB
