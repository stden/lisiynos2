program C;
var s:integer;
begin
assign(input,'checkers.in');
assign(output,'checkers.out');
reset(input);
rewrite(output);
read(s);
write('Second');
close(input);
close(output);
end.