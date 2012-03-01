for %%i in (??) do (
  copy %%i expr.in
  a
  copy expr.out %%i.u
)

erase expr.in
erase expr.out

