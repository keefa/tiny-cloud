@echo off
echo Starting curl

:loop
%~dp0bin\curl.exe http://192.168.17.106:8000
ping -n 2 127.0.0.1 >nul
goto loop
