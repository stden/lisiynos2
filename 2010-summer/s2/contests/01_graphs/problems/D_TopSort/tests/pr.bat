for %%i in (??) do (
  copy %%i topsort.in
  topsort_ash.exe
  copy  topsort.out %%i.a
)