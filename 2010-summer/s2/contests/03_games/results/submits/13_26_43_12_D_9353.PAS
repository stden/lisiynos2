program D;
var s:integer;
begin
assign(input,'nim.in');
assign(output,'nim.out');
reset(input);
rewrite(output);
read(s);
write('First');
writeln('Second');
close(input);
close(output);
end.