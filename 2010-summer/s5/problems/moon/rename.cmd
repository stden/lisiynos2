for /l %%i in (0,1,9) do (
 if exist 3_3_%%i.tst (
  rename 3_3_%%i.tst 0%%i
 )
 if exist 3_3_%%i.ans (
  rename 3_3_%%i.ans 0%%i.a
 )
)
for /l %%i in (10,1,99) do (
 if exist input%%i.txt (
  rename input%%i.txt %%i
 )
 if exist answer%%i.txt (
  rename answer%%i.txt %%i.a
 )
)


