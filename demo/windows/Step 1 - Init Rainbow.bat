@echo off
echo Stopping other services
call %~dp0bin\docker.bat service rm rainbow 2>nul
call %~dp0bin\docker.bat service rm blinkt 2>nul
call %~dp0bin\docker.bat service rm whoami 2>nul
call %~dp0bin\docker.bat service rm monitor 2>nul
echo Creating service rainbow
call %~dp0bin\docker.bat service create --name rainbow --mount type=bind,src=/sys,dst=/sys sealsystems/rainbow:1.0.0
call %~dp0bin\sleep.bat 5
