uses sysutils;

var i, n,x,y : integer;
    a: extended;

begin
   n := StrToINt(ParamStr(1));
   writeln(n);
   for i := 0 to n-1 do begin
      a := 2.0 * pi *i / n;
      x := Trunc(1e+4*cos(a));
      y := Trunc(1e+4*sin(a));
      writeln(x,' ',y);
   end;
end.
