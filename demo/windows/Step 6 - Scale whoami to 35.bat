@echo off
setlocal
set count=35
echo Scaling service rainbow to %count% replicas
call %~dp0bin\docker.bat service scale whoami=%count%
call %~dp0bin\sleep.bat 5
