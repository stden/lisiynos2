@echo off
for /l %%i in (1,1,9) do (
  REN ASTEROID0%%i.IN 0%%i
  REN ASTEROID0%%i.OUT 0%%i.a
)
for /l %%i in (10,1,99) do (
  REN ASTEROID%%i.IN %%i
  REN ASTEROID%%i.OUT %%i.a
)
