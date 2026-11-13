{$APPTYPE CONSOLE}
uses SysUtils;

var i,j,N,A,B,C,x0,Y0 : integer;
begin
  randomize;
  for i:=1 to 1000 do begin
    A := Random(10000)+1;
    B := Random(10000)+1;
    C := Random(10000)+1;
    x0 := Random(10000)+1;
    y0 := Random(10000)+1;
    writeln(A,' ',B,' ',C,' ',X0,' ',Y0);
  end;
  writeln('0 0 0');
end.