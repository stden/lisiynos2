@echo off
for %%i in (*.dpr) do (
  dcc32 -cc %%i
)

for %%i in (??) do (
  copy %%i heap.in
  solution_ft.exe 
  ren heap.out %%i.a
)

del *.exe
del heap.in