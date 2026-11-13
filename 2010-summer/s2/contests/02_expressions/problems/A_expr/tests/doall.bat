for %%i in (??) do (
  copy %%i expr.in
  expr_vm
  copy expr.out %%i.a
)

erase expr.in
erase expr.out

