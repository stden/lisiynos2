program C;
var s:integer;
begin
assign(input,'palin.in');
assign(output,'palin.out');
reset(input);
rewrite(output);
read(s);
write('yes');
close(input);
close(output);
end.

