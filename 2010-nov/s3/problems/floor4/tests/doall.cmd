copy ??.hand ??
call dcc32 -cc genall.dpr
genall.exe

dcc32 -cc ..\floor4_gk.dpr
copy ..\floor4_gk.exe solve.exe

for %%i in (??) do (
	copy %%i floor4.in
	solve.exe
	copy floor4.out %%i.a
)

del *.exe *.in *.out
