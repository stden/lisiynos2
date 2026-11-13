@echo off
dcc32 gen.dpr
copy small.in maxdist.in >nul
for %%i in (3 5 8 20 40 99) do (
 gen %%i  %%i  %%i  %%i %%i1 >>maxdist.in
 gen %%i 1%%i 1%%i  %%i %%i2 >>maxdist.in
 gen %%i 1%%i  %%i 1%%i %%i3 >>maxdist.in
 gen %%i 1%%i  %%i  %%i %%i4 >>maxdist.in
 gen %%i 1000 1000 1000 %%i5 >>maxdist.in
)
gen 100 125 1000 1000 12345 >>maxdist.in
gen 100 200 1000 1000 12345678 >>maxdist.in
