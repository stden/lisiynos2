program pr1;
var a,b,d,i,j,n,m:longint;
c:array[1..100] of integer;
begin
assign(input,'light.in');
reset(input);
assign(output,'light.out');
rewrite(output);
read(n,m);
for i:=1 to m do
begin
read(a,b);
inc(c[a]);
inc(c[b]);
end;
for i:=1 to n do
write(c[i],' ');
end.
