{$APPTYPE CONSOLE}
var

n, i : longint;
f : array [1..71] of int64;

begin
reset(input, 'b.in');
rewrite(output,'b.out');
readln(n);
f[1] := 1;
f[2] := 1;
for i := 3 to n do
 f[i] := f[i - 1] + f[i - 2];

writeln(f[n]);
end.
