{$APPTYPE CONSOLE}
uses SysUtils;

var n, res, i, j : longint;
a : array [1..100, 1..100] of byte;
b : array [1..100] of byte;
begin
 reset(input, 'color.in');
 rewrite(output,'color.out');
 readln(n);
 for i := 1 to n do begin
  for j := 1 to n do
   read(a[i][j]);
  readln;
 end;

 for i := 1 to n do
  read(b[i]);

 res := 0;

 for i := 1 to n do
  for j := 1 to n do
   if (a[i][j] = 1) and (b[i] <> b[j]) then inc(res);

 writeln(res div 2);
end.
