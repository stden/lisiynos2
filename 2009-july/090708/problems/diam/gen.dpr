uses SysUtils;
var n,i,x,y:integer;

begin
  randomize;
  n := StrToINt(PAramStr(1));
  writeln(n);
  for i := 1 to n do begin
     x := random(10000);
     y := random(10000);
     writeln(x, ' ', y);
  end;
end.