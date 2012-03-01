del *.exe
dcc32 check.dpr

for /l %%i in (4,1,9) do (
 dcc32 do0%%i.dpr
 do0%%i > 0%%i
)
for /l %%i in (10,1,20) do (
 dcc32 do%%i.dpr
 do%%i > %%i
)

run
copy *.u *.a
