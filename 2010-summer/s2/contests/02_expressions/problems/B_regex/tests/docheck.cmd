@echo off
set problem_name=regex

for %%i in (??) do (
	echo Running on test: %%i
	copy %%i %problem_name%.in > nul
	run -t 2 -m 64M %1.exe
	copy %problem_name%.out %%i.a > nul
)