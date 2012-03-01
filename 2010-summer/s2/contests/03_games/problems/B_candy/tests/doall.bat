for %%i in (??) do (
  copy %%i candy.in
  ans_gen
  move candy.out %%i.a
)

erase candy.in

