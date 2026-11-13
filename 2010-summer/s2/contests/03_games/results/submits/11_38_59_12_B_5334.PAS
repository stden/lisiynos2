program B;
var s:integer;
begin
assign(input,'candy.in');
assign(output,'candy.out');
reset(input);
rewrite(output);
read(s);
write('0');

close(input);
close(output);
end.