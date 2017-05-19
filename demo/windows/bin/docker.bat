@echo off
setlocal
set DOCKER_HOST=192.168.17.106:2376
set DOCKER_TLS_VERIFY=1
set DOCKER_CERT_PATH=%~dp0certs
echo.
echo docker %*
echo.
%~dp0docker.exe %* 2>nul
