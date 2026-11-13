program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var n,k,i,j:integer;
d:array[0..801] of int64;
begin
  reset(input,'marsian.in');
  rewrite(output,'marsian.out');
  read(n,k);
  for i:=1 to n-k+1 do d[i]:=0;
  d[0]:=1;
  for i:=0 to n+1 do
    for j:=1 to k do
      d[i+j]:=d[i+j]+d[i];
  writeln(d[n+1]);
end.
 