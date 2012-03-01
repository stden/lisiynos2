program D23dpr;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var

   k,max,n,x: longint;
   Ment: array[1..200] of longint;
begin
  assign(input,'road.in');
  assign(output,'road.out');
  max:=20001;
  readln(n);
  for k:=1 to n do read(ment[k]);
  readln(x);
  for k:=1 to n do
  begin
  if abs(x-ment[k])<max then max:=ment[k];
  end;
  writeln(max)
  { TODO -oUser -cConsole Main : Insert code here }
end.
