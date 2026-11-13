dcc32 -cc solution.dpr
dcc32 -cc -UD:\system\testlib check.dpr
# dcc32 -cc check.dpr

for %%1 in (??) do (
  copy %%1 z.in
  solution.exe 
  copy z.out %%1.a
)

del *.log
run.exe
del *.u
del *.~*
del *.dof
del z.in
del z.out