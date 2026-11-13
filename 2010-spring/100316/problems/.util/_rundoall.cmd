@echo off
pushd ..
for /d %%d in (*) do (
 echo Problem %%d
 pushd %%d
 call doall.cmd
 popd
)
popd
