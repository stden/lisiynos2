@echo off
pushd ..
for /d %%d in (*) do (
 if "%%d" neq ".util" (
  echo Problem %%d
  copy .util\doall.cmd %%d >nul
  copy .util\cleanall.cmd %%d >nul
  copy .util\wipeall.cmd %%d >nul
  copy .util\r.cmd %%d >nul
  copy .util\trans.inc %%d >nul
  copy .util\testlib.inc %%d >nul
  copy .util\*.dpr %%d >nul
  copy .util\*.exe %%d >nul
  echo @echo off>%%d\include.cmd
  echo set TASK=%%d>>%%d\include.cmd
  echo set SOL=%%TASK%%>>%%d\include.cmd
  echo set HAND=>>%%d\include.cmd
 )
)
popd
