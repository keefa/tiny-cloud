@echo off
setlocal
set count=7
echo Scaling service rainbow to %count% replicas
call %~dp0bin\docker.bat service scale rainbow=%count%
call %~dp0bin\sleep.bat 5
