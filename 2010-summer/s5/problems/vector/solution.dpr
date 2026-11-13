{$apptype console}

uses SysUtils;

var
  X,Y,Z : Extended;
begin
  assign(input,'vector.in'); reset(input);
  assign(output,'vector.out'); rewrite(output);
  readln(X,Y,Z);
  Writeln(sqrt(X*X+Y*Y+Z*Z):0:2);
end.
