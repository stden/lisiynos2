for %%i in (??) do (
  copy %%i checkers.in
  solution
  move checkers.out %%i.a
)

erase checkers.in

