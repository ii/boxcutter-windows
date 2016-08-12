@setlocal EnableDelayedExpansion EnableExtensions
@for %%i in (%~dp0\_packer_config*.cmd) do @call "%%~i"
@if defined PACKER_DEBUG (@echo on) else (@echo off)

title Installing some windows Features. Please wait...

echo ==^> Installing Feature NetFx3

DISM.exe /online /quiet /enable-feature /all /featurename:NetFx3

:exit0

ver>nul

goto :exit

:exit1

verify other 2>nul

:exit
