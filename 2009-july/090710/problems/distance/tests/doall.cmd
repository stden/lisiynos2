@echo off
set TASK=distance
gendist.py
for %%i in (04 04 05 06 07 08 09 10 11 12 13) do (
 echo Running on test %%i
 copy %%i %TASK%.in >nul
 ..\%TASK%_ik
 move %TASK%.out %%i.a >nul
)
erase %TASK%.in
