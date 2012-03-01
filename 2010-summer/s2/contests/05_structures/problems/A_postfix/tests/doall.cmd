set name=postfix


split_tests.exe

rem generate answers

for %%i in (??) do (
  copy %%i %name%.in
  postfix.exe
  move %name%.out %%i.a
)

del *.in
del *.out
