rem gentest 5 6 4 > 02
rem gentest 77 6 4 > 03
rem gentest 3 10 11 > 04
rem gentest 7 20 17 > 05
rem gentest 19 17 65 > 06
rem gentest 56 75 100 > 07
rem gentest 31 100 4950 > 08
gentest 31 100 200 > 09
gentest 31 100 100 > 10
gentest 31 100 50 > 11


for %%i in (??) do (
  copy %%i matrix.in
  solution
  copy matrix.out %%i.a
)

erase matrix.in
erase matrix.out

