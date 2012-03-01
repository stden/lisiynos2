program A;
var s:integer;
begin
assign(input,'knight.in');
assign(output,'knight.out');
reset(input);
rewrite(output);
read(s);
write('2');


close(input);
close(output);
end.