{$APPTYPE CONSOLE}

Uses Math;

var
  A,B,C,x0,y0 : Longint;
  D : Extended;
begin
  assign(input,'dist.in'); reset(input);
  assign(output,'dist.out'); rewrite(output);
  {}
  while true do begin
    read(A,B,C,x0,y0);
    if (A=0) and (B=0) and (C=0) then break;
    {}
    D := abs(A*x0+B*y0+C)/Sqrt(A*A+B*B);
    writeln(D:0:3);
  end;
end.
