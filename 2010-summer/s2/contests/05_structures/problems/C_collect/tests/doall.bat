dcc32 -cc solution.dpr
dcc32 -cc gentest.dpr

gentest 100 50 543345 100 100 > 02
gentest 1000 500 5543 1000 100 > 03
gentest 1 100000 545 1 100 > 04
gentest 10000 10000 657 1000000 1000000 > 05
gentest 100 100000 6654 100 100 > 06
gentest 100000 100000 54353 20000000 20000000 > 07

for %%i in (??) do (
  copy %%i butterfly.in
  solution 
  copy butterfly.out %%i.a
)

erase solution.exe
erase gentest.exe
erase butterfly.in
erase butterfly.out

