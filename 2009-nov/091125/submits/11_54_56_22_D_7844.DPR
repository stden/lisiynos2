{$APPTYPE CONSOLE}

uses
  SysUtils;
var j, i, n, y : longint;
s, q : string;
begin
 reset(input,'d.in');
 rewrite(output,'d.out');
 readln(n);
 for j := 1 to 256 do
  for i := 1 to j do begin
   str(i, q);
   s := s + q;
  end;

 writeln(s[n]);
end.
