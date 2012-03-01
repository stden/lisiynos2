{$APPTYPE CONSOLE}
uses testlib;

var n:longint;
    a,b:longint;
    i:longint;

begin
n:=inf.readlongint;
for i:=1 to 3*n do
  if ouf.readlongint<>ans.readlongint then quit(_WA,'');

quit(_OK,'');


end.