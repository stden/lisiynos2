for /l %%i in (0,1,9) do (
 if exist 3_2_%%i.tst (
  rename 3_2_%%i.tst 0%%i
 )
 if exist 3_2_%%i.ans (
  rename 3_2_%%i.ans 0%%i.a
 )
)
for /l %%i in (10,1,99) do (
 if exist 3_2_%%i.tst (
  rename 3_2_%%i.tst %%i
 )
 if exist 3_2_%%i.ans (
  rename 3_2_%%i.ans %%i.a
 )
)


