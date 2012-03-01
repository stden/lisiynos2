program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var f1,f2:text;
    a:array[1..100] of integer;
    n,i,x,solv,min:integer;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(f1,'road.in');
  reset(f1);
  assign(f2,'road.out');
  rewrite(f2);
  readln(f1,n);
  for i:=1 to n do
   read(f1,a[i]);
  readln(f1,x);
  solv:=1;
  min:=abs(a[1]-x);
  for i:=2 to n do
   if abs(a[i]-x)<min then
                       begin
                        min:=abs(a[i]-x);
                        solv:=i;
                       end;
  writeln(f2,solv);
  CLOSE(f1);
  close(f2);
end.
 