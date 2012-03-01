for /l %%i in (0,1,9) do (
 if exist input0%%i.txt (
  rename input0%%i.txt 0%%i
 )
 if exist answer0%%i.txt (
  rename answer0%%i.txt 0%%i.a
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


