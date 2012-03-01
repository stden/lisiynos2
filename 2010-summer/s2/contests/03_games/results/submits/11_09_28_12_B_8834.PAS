program B;
n:mark [1..500] of integer;
m:mark [1..100] of integer;
begin
assign(input,'candy.in');
assign(output,'candy.out');
reset(input);
rewrite(output);
read(s);


close(input);
close(output);
end.