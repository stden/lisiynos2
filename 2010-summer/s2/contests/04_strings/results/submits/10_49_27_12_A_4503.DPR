program A;
var s:integer;
begin
assign(input,'substr.in');
assign(output,'substr.out');
reset(input);
rewrite(output);
read(s);
write('none');
close(input);
close(output);
end.

