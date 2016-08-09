@setlocal EnableDelayedExpansion EnableExtensions
@for %%i in (a:\_packer_config*.cmd) do @call "%%~i"
@if defined PACKER_DEBUG (@echo on) else (@echo off)

if not defined MGMT_FRAMEWORK_URL set MGMT_FRAMEWORK_URL=https://download.microsoft.com/download/2/c/6/2c6e1b4a-ebe5-48a6-b225-2d2058a9cefb/win8.1andw2k12r2-kb3134758-x64.msu

for %%i in ("%MGMT_FRAMEWORK_URL%") do set MGMT_FRAMEWORK=%%~nxi
set MGMT_FRAMEWORK=%TEMP%\mgmt_framework
set MGMT_FRAMEWORK_PATH=%MGMT_FRAMEWORK%\%MGMT_FRAMEWORK%
set AUTHORIZED_KEYS=%USERPROFILE%\.ssh\authorized_keys

echo ==^> Creating "%MGMT_FRAMEWORK%"
mkdir "%MGMT_FRAMEWORK%"
pushd "%MGMT_FRAMEWORK%"

if exist "%SystemRoot%\_download.cmd" (
  call "%SystemRoot%\_download.cmd" "%MGMT_FRAMEWORK_URL%" "%MGMT_FRAMEWORK_PATH%"
) else (
  echo ==^> Downloading "%MGMT_FRAMEWORK_URL%" to "%MGMT_FRAMEWORK_PATH%"
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%MGMT_FRAMEWORK_URL%', '%MGMT_FRAMEWORK_PATH%')" <NUL
)
if not exist "%MGMT_FRAMEWORK_PATH%" goto exit1

wusa.exe "%MGMT_FRAMEWORK_PATH%" /quiet /restart
:exit0

@ping 127.0.0.1
@ver>nul

@goto :exit

:exit1

@ping 127.0.0.1
@verify other 2>nul

:exit

@echo ==^> Script exiting with errorlevel %ERRORLEVEL%
@exit /b %ERRORLEVEL%


