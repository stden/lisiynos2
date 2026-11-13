@echo off
:label
c:
cd \testsys
testsys
if errorlevel 255 goto label
if errorlevel 1 goto stop
goto exit
:stop
pause
:exit
exit
