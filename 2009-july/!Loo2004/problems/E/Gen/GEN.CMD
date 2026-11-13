for %%i in (07,08,09) do (
  copy %%i.in e.in
  e.exe
  copy e.out %%i.out
  del e.in
  del e.out
)
for /l %%i in (10,1,30) do (
  copy %%i.in e.in
  e.exe
  copy e.out %%i.out
  del e.in
  del e.out
)