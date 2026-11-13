{$APPTYPE CONSOLE}
uses testlib;
const nmax=100;

var a:array[1..nmax] of longint;
    n:longint;
    x:longint;
    i:longint;
    b,c:longint;

begin
  n:=inf.readlongint;
  for i:=1 to n do
    a[i]:=inf.readlongint;
  x:=inf.readlongint;
  b:=ans.readlongint;
  c:=ouf.readlongint;
  if (c<1) or (c>n) then quit(_PE,'Wrong number in output');
  if abs(x-a[b])<abs(x-a[c]) then quit(_WA,'Answer is not optimal');
  if abs(x-a[b])=abs(x-a[c]) then quit(_OK,'');
  quit(_Fail,'Unexpected error or error in jury solution');
end.


