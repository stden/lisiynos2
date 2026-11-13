program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
a:array[1..100,1..100] of byte;
color:array[1..100] of byte;
i,j,n,k:integer;
begin
  reset(input,'color.in');
  rewrite(output,'color.out');
  read(n);
  for i:=1 to n do for j:=1 to n do read(a[j,i]);
  for i:=1 to n do read(color[i]);
  k:=0;
  for i:=1 to n do for j:=1 to n do if (a[i,j]=1) and (color[i]<>color[j]) then inc(k);
  writeln(k div 2);
end.
 