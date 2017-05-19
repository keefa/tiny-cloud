@echo off
setlocal
echo Updating service whoami to show OS/Arch
call %~dp0bin\docker.bat service update --image stefanscherer/whoami:1.2.0 --update-parallelism 5 whoami
call %~dp0bin\sleep.bat 5
