@echo off
setlocal enabledelayedexpansion
set DIRECTORY=%1
set OUTPUT=

if exist "%DIRECTORY%\*" (
	break > collectedanexos.tmp
    for %%f in (%DIRECTORY%\*.tex) do (
		set "str=%%f"
		set "str=!str:\=/!"
		set "OUTPUT=!OUTPUT!,!str!"
    )
)
echo %OUTPUT:~1% > collectedanexos.tmp
endlocal
