program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var n,i:longint;
    a:array[1..1000000] of longint;
    f1,f2:text;
procedure sort;
 var i,j,t:integer;
 begin
  for i:=n downto 1 do
   for j:=1 to i do
    if a[j]>a[i] then
     begin
      t:=a[j];
      a[j]:=a[i];
      a[i]:=t;
     end;
 end;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(f1,'sort.in');
  reset(f1);
  assign(f2,'sort.out');
  rewrite(f2);
  readln(f1,n);
  for i:=1 to n do
   read(f1,a[i]);
  sort;
  for i:=1 to n do
   write(f2,a[i],' ');
  CLOSE(f1);
  close(f2);
end.
