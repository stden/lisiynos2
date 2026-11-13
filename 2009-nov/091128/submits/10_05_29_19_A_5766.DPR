program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  math;

var
i,sum,n,c,x1,x2,y1,y2  : integer;
a : array [1..5000, 1..2] of integer;

begin
reset(input,'left.in');
rewrite(output,'left.out');
readln(n);

for i := 1 to n do
readln(a[i,1], a[i,2]);
sum := 0;

for i:= 1 to n - 2 do begin
  x1 := a[i + 1,1] - a[i,1];
  y1 := a[i + 1,2] - a[i,2];
  x2 := a[i + 2,1] - a[i + 1,1];
  y2 := a[i + 2,2] - a[i + 1,2];
  c := x1 * y2 - x2 * y1;
  if c > 0 then
  sum:=sum+666;
end;

writeln(sum, '$');
end.
