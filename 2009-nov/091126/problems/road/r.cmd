@echo off
for /l %%i in (1,1,9) do (
  REN INPUT0%%i.TXT 0%%i
  REN ANSWER0%%i.TXT 0%%i.a
)
for /l %%i in (10,1,99) do (
  REN INPUT%%i.TXT %%i
  REN ANSWER%%i.TXT %%i.a
)
