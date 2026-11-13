@echo off
set problem_name=interval
del *.a

for %%i in (*.dpr) do (
  dcc32 -cc %%i
)

for %%i in (*.pas) do (
  dcc32 -cc %%i
)



for %%i in (??) do (
  copy %%i %problem_name%.in
  interval_ft.exe
  echo %%i
  ren %problem_name%.out %%i.a
)

del *.exe
del %problem_name%.in
del %problem_name%.out