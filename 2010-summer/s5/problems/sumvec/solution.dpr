{$apptype console}

uses SysUtils;

var
  X1,Y1,Z1,X2,Y2,Z2 : Extended;
begin
  assign(input,'sumvec.in'); reset(input);
  assign(output,'sumvec.out'); rewrite(output);
  readln(X1,Y1,Z1);
  readln(X2,Y2,Z2);
  Writeln((X1+X2):0:2,' ',(Y1+Y2):0:2,' ',(Z1+Z2):0:2);
end.
