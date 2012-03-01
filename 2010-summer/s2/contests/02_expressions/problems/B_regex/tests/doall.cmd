@echo off
call cl doall.cpp -o doall.exe
call doall.exe
del *.out
del *.obj
del regex.in
del regex.out