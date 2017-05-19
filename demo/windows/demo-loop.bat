@echo off
setlocal
:loop
call "%~dp0Step 1 - Init Rainbow.bat"
call %~dp0bin\sleep.bat 5
call "%~dp0Step 2 - Scale Rainbow to 3.bat"
call %~dp0bin\sleep.bat 15
call "%~dp0Step 2 - Scale Rainbow to 7.bat"
call %~dp0bin\sleep.bat 20
call "%~dp0Step 4 - Init whoami.bat"
call %~dp0bin\sleep.bat 5
call "%~dp0Step 6 - Scale whoami to 35.bat"
call %~dp0bin\sleep.bat 30
call "%~dp0Step 7 - Update whoami.bat"
call %~dp0bin\sleep.bat 30
call "%~dp0Step 8 - Scale whoami down to 3.bat"
call %~dp0bin\sleep.bat 5
goto loop
