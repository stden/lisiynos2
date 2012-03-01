program Interval;
var i, j, n, k, p,min, b:longint;
    a: array [1..150000] of longint;
begin
assign(input,'interval.in');
assign(output,'interval.out');
reset(input);
rewrite(output);
read(n, k);
readln;
for i:=1 to n do begin
read(a[i]);  end;
for i:=1 to n-k+1 do begin
min:=a[i+1];
if a[i]<=min then begin
min:=a[i];
writeln (min); end; end;
close(input);
close(output);
end.








.
