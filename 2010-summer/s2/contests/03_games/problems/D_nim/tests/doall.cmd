set name=nim


call split_tests

call genrand 4 0 > 16
call genrand 5 1 > 17
call genrand 10 0 > 18
call genrand 11 1 > 19
call genrand 21 0 > 20
call genrand 20 1 > 21
call genrand 99 0 > 22
call genrand 99 1 > 23
call genrand 100 0 > 24
call genrand 100 1 > 25


rem generate answers

for %%i in (??) do (
  copy %%i %name%.in
  call solution
  move %name%.out %%i.a
)

del *.in
del *.out
