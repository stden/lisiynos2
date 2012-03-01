rem @echo off
set %FileName = rec
set 
for /l %%i in (1,1,9) do (
  REN rec0%%i.IN 0%%i
  REN rec0%%i.OUT 0%%i.a
)
for /l %%i in (10,1,99) do (
  REN rec%%i.IN %%i
  REN rec%%i.OUT %%i.a
)
