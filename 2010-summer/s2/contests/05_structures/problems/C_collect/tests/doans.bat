for %%i in (??) do (
  copy %%i collect.in
  solution 
  copy collect.out %%i.a
)

erase solution.exe
erase gentest.exe
erase butterfly.in
erase butterfly.out

