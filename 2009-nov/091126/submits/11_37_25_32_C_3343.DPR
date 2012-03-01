program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var num:array[1..1000] of integer;
i,n,m,a:integer;
begin
  reset(input,'light.in');
  rewrite(output,'light.out');
  read(n);
  for i:=1 to n do num[i]:=0;
  read(m);
  for i:=1 to m do begin
  read(a);
  inc(num[a]);
  read(a);
  inc(num[a]);
  end;
  for i:=1 to n-1 do write(num[i],' ');
  writeln(num[n]);
end.
 