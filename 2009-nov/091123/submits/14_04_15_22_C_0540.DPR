{$APPTYPE CONSOLE}
var

n : longint;
res : int64;
d : array [1..999999] of longint;

function f( x : integer) : longint;
	begin
		if d[x] = 0 then d[x] := f(x - 1) + f(x - 2) + f(x - 3);
		f := d[x]
	end;
begin
reset(input, 'c.in');
rewrite(output,'c.out');
readln(n);
d[1] := 1;
d[2] := 2;
d[3] := 4;

writeln(f(n));
end.
