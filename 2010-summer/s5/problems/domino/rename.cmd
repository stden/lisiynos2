for /l %%i in (0,1,9) do (
 if exist test0%%i.DAT (
  rename test0%%i.DAT 0%%i
 )
 if exist test0%%i.SOL (
  rename test0%%i.SOL 0%%i.a
 )
)
for /l %%i in (10,1,99) do (
 if exist test%%i.DAT (
  rename test%%i.DAT %%i
 )
 if exist test%%i.SOL (
  rename test%%i.SOL %%i.a
 )
)


