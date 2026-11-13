Var
a:array [1..100] of integer;
n,i,c,e:longint;
begin
assign (input, 'nim.in');
assign (output, 'nim.out');
reset (input);
rewrite (output);
readln(n);
if n=1   then
WriteLn('First') else
begin
for e:=1 to n do
read(a[e]);
For e:=1 to n do
c:=c xor a[e];
if c <> 0 then writeln('First') else
writeln ('Second');
end;
close(input);
close(output);
end.