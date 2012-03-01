var n, m, k,i: longINT;
Var a:array [1..100] of integer;
begin
assign(input,'nim.in');
assign(output,'nim.out');
reset(input);
rewrite(output);
read(n);
for i:=1 to n do
write(a[i]);
for i:=1 to n do
if a[1]=1 then write('First') else write ('Second');
close(input);
close(output);
end.