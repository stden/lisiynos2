{$APPTYPE CONSOLE}
var

n, i, j : longint;
a, b : array [1..1000, 1.. 1000] of int64;

function f(x, y : int64) : int64;
begin
 if (b[x][y] < 0) then
	if f(x - 1, y) > f(x, y - 1)
	then b[x][y] := f(x - 1, y) + a[x][y]
	else b[x][y] := f(x, y - 1) + a[x][y];
 f := b[x][y]
end;

begin
reset(input, 'd.in');
rewrite(output,'d.out');
readln(n);
for i := 1 to n do begin
 for j := 1 to n do
  read(a[i][j]);
end;

for i := 1 to n do
 a[i][n + 1] := -1;
for i := 1 to n do
 a[n + 1][i] := -1;

for i:=1 to n do
		 for j:=1 to n do
		     	if b[i - 1][j] > b[i][j - 1]
			then b[i][j] := b[i - 1][j] + a[i][j]
			else b[i][j] := b[i][j - 1] + a[i][j];

writeln(f(n, n));
end.
