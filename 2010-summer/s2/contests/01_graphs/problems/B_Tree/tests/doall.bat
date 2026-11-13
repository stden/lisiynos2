gen1 1 0 01
gen1 2 0 02
gen1 5 0 03
gen1 10 0 04
gen1 20 0 05
gen1 50 0 06
gen1 70 0 07
gen1 90 0 08
gen1 100 0 09
gen1 1 1 10
gen1 2 1 11
gen1 5 1 12
gen1 10 1 13
gen1 20 1 14
gen1 50 1 15
gen1 70 1 16
gen1 90 1 17
gen1 100 1 18
gen2 1 0 19
gen2 2 0 20
gen2 5 0 21
gen2 10 0 22
gen2 20 0 23
gen2 50 0 24
gen2 70 0 25
gen2 90 0 26
gen2 100 0 27
gen2 1 1 28
gen2 2 1 29
gen2 5 1 30
gen2 10 1 31
gen2 20 1 32
gen2 50 1 33
gen2 70 1 34
gen2 90 1 35
gen2 100 1 36



for %%i in (??) do (
  copy %%i tree.in
  solution_dmk.exe
  copy  tree.out %%i.a
)