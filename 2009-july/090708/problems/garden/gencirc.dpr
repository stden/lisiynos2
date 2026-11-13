uses sysutils;

var i, n,x,y : integer;
    a: extended;

begin
   n := StrToINt(ParamStr(1));
   writeln(n);
   for i := 0 to n-1 do begin
      a := 2.0 * pi *i / n;
      x := Trunc(1e+2*cos(a))-1000;
      y := Trunc(1e+2*sin(a))+1000;
      writeln(x,' ',y);
   end;
end.
