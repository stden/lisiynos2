@echo off
set TASK=connect
gen.py
for %%i in (01 02 03 04 05 06 07 08 09 10 11 12) do (
 echo Running on test %%i
 copy %%i %TASK%.in >nul
 ..\%TASK%_ik
 move %TASK%.out %%i.a >nul
)
erase %TASK%.in
