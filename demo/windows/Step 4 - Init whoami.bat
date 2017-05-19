@echo off
echo Stopping other services
call %~dp0bin\docker.bat service rm rainbow 2>nul
call %~dp0bin\docker.bat service rm blinkt 2>nul
call %~dp0bin\docker.bat service rm whoami 2>nul
call %~dp0bin\docker.bat service rm monitor 2>nul
echo Creating service monitor
call %~dp0bin\docker.bat service create --mode global --restart-condition any --name monitor --mount type=bind,src=/sys,dst=/sys --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock stefanscherer/monitor:1.1.0
echo Creating service whoami
call %~dp0bin\docker.bat service create --name whoami --publish 8000:8000 -e PORT=8000 stefanscherer/whoami:1.1.0
call %~dp0bin\sleep.bat 5
