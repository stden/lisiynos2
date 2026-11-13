program qqq;
var f:text;
    a,s,d:longint;
begin
assign(f,'checkers.in');
reset(f);
read(f,a);
read(f,s);
read(f,d);
close(f);
assign(f,'checkers.out');
rewrite(f);
if s+1=d then write(f,'Second')
   else write(f,'First');
close(f);
end.