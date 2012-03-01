for %%i in (??) do (
  copy %%i tree.in
  solution.exe
  copy  tree.out %%i.a
)