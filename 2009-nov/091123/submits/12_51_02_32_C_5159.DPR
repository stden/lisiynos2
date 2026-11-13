program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var f,t:text;
d:array[1..41] of int64;
n,i:integer;
begin
  assign(f,'c.in');
  assign(t,'c.out');
  reset(f);
  rewrite(t);
  read(f,n);
  d[1]:=1;
  d[2]:=1;
  for i:=3 to n+1 do begin
    d[i]:=d[i-2]+d[i-3]+d[i-1];
  end;
  writeln(t,d[n+1]);
  close(f);
  close(t);
end.
