@echo off
setlocal
echo Updating service rainbow
call %~dp0bin\docker.bat service update --image sealsystems/rainbow:1.0.0 rainbow
call %~dp0bin\sleep.bat 5
