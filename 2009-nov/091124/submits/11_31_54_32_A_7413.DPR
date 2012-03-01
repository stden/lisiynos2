program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var n,i:integer;
k:boolean;
begin
  reset(input,'simple.in');
  rewrite(output,'simple.out');
  read(n);
  i:=2;
  k:=false;
  repeat
    if n mod i =0 then k:=true;
    inc(i);
  until k or (i>round(sqrt(n)));
  if k then writeln('1') else writeln('0');
end.
 