for /d %%t in (*) do (
  dcc32 %%t\check.dpr
  pushd %%t
  run
  ren *.u *.a
  popd 
)
