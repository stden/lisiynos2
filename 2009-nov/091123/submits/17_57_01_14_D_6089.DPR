program D4;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
   f1,f2: text;
   k,max,n,x: longint;
   Ment: array[1..200] of longint;
begin
  assign(f1,'road.in');
  assign(f2,'road.out');
  reset(f1);
  rewrite(f2);
  max:=20001;
  readln(f1,n);
  for k:=1 to n do read(f1,ment[k]);
  readln(f1,x);
  for k:=1 to n do
  begin
  if abs(x-ment[k])<abs(max-x) then max:=ment[k];
  end;
  writeln(f2,max);
  close(f1);
  close(f2);
  { TODO -oUser -cConsole Main : Insert code here }
end.
