{$APPTYPE CONSOLE}

uses
  SysUtils;
var m, i, n, y, u, j : longint;
s, q : string;
begin
 reset(input,'b.in');
 rewrite(output,'b.out');
 readln(n, m);
 y := 0;

 for i := 1 to n do
  for j := 1 to i do begin
   str(i, q);
   s := s + q;
   inc(y, length(q));


  end;

 u := y div m;


 for i := 0 to u  do begin
  for j := 1 to m do
   write(s[j + m * i]);
   writeln;
 end;

 {u := y mod m;
 writeln;
 if u <> 0 then
 for j := y - u to y do
  write(s[j]);  }


end.
