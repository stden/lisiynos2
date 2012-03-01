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
write(f,k);
close(f);
end.