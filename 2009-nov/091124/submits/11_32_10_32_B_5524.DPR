program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var n,i,j,a,mini:integer;
s,min:int64;
begin
 reset(input,'unreal.in');
 rewrite(output,'unreal.out');
 read(n);
 min:=2000000000;
 mini:=0;
 for i:=1 to n do begin
  s:=0;
  for j:=1 to n-1 do begin
    read(a);
    s:=s+a;
  end;
  if s<min then begin
    min:=s;
    mini:=i;
  end;
 end;
  writeln(mini);
end.
