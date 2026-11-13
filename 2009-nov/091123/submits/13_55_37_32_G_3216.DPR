program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var f,t:text;
n,k,u,j,i:integer;
ans:int64;
d:array[1..30,0..30] of int64;
begin
  assign(f,'g.in');
  assign(t,'g.out');
  reset(f);
  rewrite(t);
  read(f,n,k);
  for i:=1 to k-1 do d[1,i]:=1;
  for i:=2 to n do begin
    for j:=0 to k-1 do for u:=0 to k-1 do d[i,j]:=d[i,j]+d[i-1,u];
    d[i,0]:=d[i,0]-d[i-1,0];
  end;
  for i:=0 to k-1 do ans:=ans+d[n,i];
  writeln(t,ans);
  close(f);
  close(t);
end.
 