program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  a,b,c,d,r: integer;

begin
  assign(input,'d1.in');
  reset(input);
  readln(a,b,c,d);
  close(input);
  if d > b
  then
    r := a+(d-b)*c
  else
    r := a;
  assign(output,'d1.out');
  rewrite(output);
  writeln(r);
  close(output);
end.
