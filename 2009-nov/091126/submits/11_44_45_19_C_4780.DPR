program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..100]of integer;
i,j,n,m,b,c:integer;
begin
reset(input, 'light.in');
rewrite(output, 'light.out');
readln(n,m);
for i:= 1 to m do begin
  readln(b,c);
  inc(a[b]);
  inc(a[c]);
end;
for i:=1 to n do begin
  write(a[i],' ');
end;
end.
