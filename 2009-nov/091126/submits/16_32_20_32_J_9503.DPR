program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..100000] of integer;
i,n,b,j:integer;
begin
  reset(input,'sort.in');
  rewrite(output,'sort.out');
  read(n);
  for i:=1 to n do a[i] :=0;
  for i:=1 to n do begin
  read(b);
  inc(a[b]);
  end;
  for i:=1 to 100000 do for j:=1 to a[i] do write(i,' ');
  writeln;
end.
 