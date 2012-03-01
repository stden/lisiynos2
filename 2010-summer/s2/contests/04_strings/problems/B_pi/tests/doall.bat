for %%i in (??) do (
  copy %%i pi.in
  solution
  copy pi.out %%i.a
)

erase pi.in
erase pi.out

