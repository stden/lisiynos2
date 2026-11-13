dcc32 -cc gen.dpr
dcc32 -cc -UO:\testlib check.dpr

for %%1 in (??) do gen.exe < %%1 > %%1.a
