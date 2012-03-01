for /l %%i in (0,1,9) do (
 if exist 00%%i.dat (
  rename 00%%i.dat 0%%i
 )
 if exist 00%%i.ans (
  rename 00%%i.ans 0%%i.a
 )
)
for /l %%i in (10,1,99) do (
 if exist 0%%i.dat (
  rename 0%%i.dat %%i
 )
 if exist 0%%i.ans (
  rename 0%%i.ans %%i.a
 )
)


