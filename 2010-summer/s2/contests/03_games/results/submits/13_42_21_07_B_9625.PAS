program qqq;
var a:integer;
    k:byte;
    f:text;
begin
assign(f,'candy.in');
reset(f);
read(f,a);
read(f,k);
close(f);
assign(f,'candy.out');
rewrite(f);
if (a-k=k+1) or (k>=a) then write(f,a) else
write(f,'0');
close(f);
end.