program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var i,n,min,mini,m:integer;
a:array[1..100] of integer;
begin
  reset(input,'road.in');
  rewrite(output,'road.out');
  read(n);
  for i:=1 to n do read(a[i]);
  read(m);
  min:=1000000;
  for i:=1 to n do if abs(a[i]-m) < min then begin
  mini:=i;
  min:=abs(a[i]-m);
  end;
  writeln(mini);
end.
 