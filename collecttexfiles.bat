@echo off
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM  USP-DOC
REM  Template para documentos técnicos das USP
REM
REM  Copyright (c) 2023 Estevão Soares dos Santos
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
