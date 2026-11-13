program qq;
var f:text;
    a,k:integer;
begin
assign(f,'candy.in');
reset(f);
read(f,a,k);
close(f);
assign(f,'candy.out');
rewrite(f);
if a-k=k+1 then write(f,k)
else write(f,'0');
close(f);
end.