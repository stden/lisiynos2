@echo off
for /l %%i in (1,1,9) do (
  REN dwarfs0%%i.IN 0%%i
  REN dwarfs0%%i.OUT 0%%i.a
)
for /l %%i in (10,1,99) do (
  REN dwarfs%%i.IN %%i
  REN dwarfs%%i.OUT %%i.a
)
