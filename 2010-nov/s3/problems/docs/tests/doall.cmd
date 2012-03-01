for %%i in (*.dpr) do dcc32 -cc %%i

copy 01.manual 01
copy 02.manual 02

do03 >03
do04 >04
do05 >05
do06 >06
do07 >07
do08 >08
do09 >09
do10 >10
do11 >11
do12 >12

copy ../docs.dpr ./docs.dpr

dcc32 -cc docs.dpr

for %%i in (??) do (
  copy %%i docs.in
  docs.exe
  copy docs.out %%i.a
)

del docs.* docs_as.cpp problem.properties
for %%i in (*.exe) do del %%i
