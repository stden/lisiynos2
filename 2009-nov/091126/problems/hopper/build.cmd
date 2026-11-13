del *.u
del *.exe
del *.a
del *.log
dcc32 check.dpr
dcc32 solution.dpr
run
ren *.u *.a
