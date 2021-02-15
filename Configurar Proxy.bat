:: Hide Command and Set Scope
@echo off
setlocal EnableExtensions

:: Customize Window
title Configurando Proxy

:: Menu Options
:: Specify as many as you want, but they must be sequential from 1 with no gaps
:: Step 1. List the Application Names
set "App[1]=SMSPLB"
set "App[2]=REDE_EXECUTIVA"


:: Display the Menu
set "Message= Configuracoa e Correcao de Proxy de Rede"
:Menu
cls
echo.%Message%
echo.
echo.  Proxy
echo.
set "x=0"
:MenuLoop
set /a "x+=1"
if defined App[%x%] (
    call echo   %x%. %%App[%x%]%%
    goto MenuLoop
)
echo.

:: Prompt User for Choice
:Prompt
set "Input="
set /p "Input=Selecione seu proxy:"

:: Validate Input [Remove Special Characters]
if not defined Input goto Prompt
set "Input=%Input:"=%"
set "Input=%Input:^=%"
set "Input=%Input:<=%"
set "Input=%Input:>=%"
set "Input=%Input:&=%"
set "Input=%Input:|=%"
set "Input=%Input:(=%"
set "Input=%Input:)=%"
:: Equals are not allowed in variable names
set "Input=%Input:^==%"
call :Validate %Input%

:: Process Input
call :Process %Input%
goto End


:Validate
set "Next=%2"
if not defined App[%1] (
    set "Message=Invalid Input: %1"
    goto Menu
)
if defined Next shift & goto Validate
goto :eof


:Process
set "Next=%2"
call set "App=%%App[%1]%%"
echo executando script de proxy

if "%App%" EQU "SMSPLB" Powershell.exe -executionpolicy Unrestricted -File  \\smsubatsi002\comp\scripts\proxysmsplb.ps1 | echo Executando configuracao do proxy SMSPLB aguarde...

if "%App%" EQU "REDE_EXECUTIVA" Powershell.exe -executionpolicy Unrestricted -File  \\smsubatsi002\comp\scripts\proxyRedeExecutiva.ps1 | echo Executando configuracao do proxy REDE_EXECUTIVA aguarde...

:: Prevent the command from being processed twice if listed twice.
set "App[%1]="
if defined Next shift & goto Process
goto :eof


:End
endlocal
echo Pressione uma tecla para sair. 
pause >nul