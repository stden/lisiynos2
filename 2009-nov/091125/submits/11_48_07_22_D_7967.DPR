{$APPTYPE CONSOLE}

uses
  SysUtils;
var j, i, n, y : longint;

begin
 reset(input,'d.in');
 rewrite(output,'d.out');
 readln(n);
 y := 0;

 for j := 1 to 256 do
  for i := 1 to j do begin
   inc(y);
   if y = n then begin
    writeln(i);
    exit;
   end;
  end;
end.
