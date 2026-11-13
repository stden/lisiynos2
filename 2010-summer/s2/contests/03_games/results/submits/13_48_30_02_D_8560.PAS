var n, m, k,i: longINT;
Var a:array [1..100] of integer;
begin
assign(input,'nim.in');
assign(output,'nim.out');
reset(input);
rewrite(output);
read(n);
for i:=1 to n do
read(a[i]);
if n mod 2=0 then write('Second') else write ('First');
close(input);
close(output);
end.