@echo off
del *.exe
del *.u
set TASK=bubble
set SOL=f_bv
set HAND=
echo Compiling solution and checker...
if exist %SOL%.cpp (
 g++ -O2 -Wall -Wl,--stack=67108864 %SOL%.cpp -o solution.exe
) else if exist %SOL%.c (
 gcc -x c -O2 -Wall -Wl,--stack=67108864 %SOL%.c -o solution.exe
)
if exist check_f.cpp (
 g++ -O2 -Wall -Wl,--stack=67108864 check_f.cpp -o check.exe
) else if exist check.dpr (
 dcc32 -cc check.dpr -e. -I%TESTLIB% -U%TESTLIB%
) else (
 echo Can not compile checker!
)
run
ren *.u *.a
echo Done!
