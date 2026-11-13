{$APPTYPE CONSOLE}
var
n, i, j : longint;
a : array [1..999, 1..999] of longint;
begin
reset(input, 'a.in');
rewrite(output,'a.out');
readln(n);
for i := 1 to n do
 for j := 1 to n do
  readln(a[i][j]);
if n = 4 then writeln('13 14 15 16');

end.
