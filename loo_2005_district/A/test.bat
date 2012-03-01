@echo off
REM Тесты с 01 до 10
for %%i in (01 02 03 04 05 06 07 08 09 10) do (
  COPY %%i connect.in
  REM Запуск решения ученика
  solution.exe 
  REM Проверка результата
  check.exe %%i connect.out %%i.a 
)
