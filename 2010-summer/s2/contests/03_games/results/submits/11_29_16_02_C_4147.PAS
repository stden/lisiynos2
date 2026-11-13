var m,l,r:longINT;
begin
assign(input,'checkers.in');
assign(output,'checkers.out');
reset(input);
rewrite(output);
read(m);
read(r,l);
if l=r-1 then write('Second') else write('First');
close(input);
close(output);
end.