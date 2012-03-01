del *.exe
del *.u
del *.a
dcc32 solution.dpr
dcc32 check.dpr
run
copy *.u *.a
run
