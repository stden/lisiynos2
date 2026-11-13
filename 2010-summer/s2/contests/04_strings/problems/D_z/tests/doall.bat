for %%i in (??) do (
  copy %%i z.in
  solution
  copy z.out %%i.a
)

erase z.in
erase z.out

