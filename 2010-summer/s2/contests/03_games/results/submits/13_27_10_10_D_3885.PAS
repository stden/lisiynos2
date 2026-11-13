var a:integer;
begin
assign (output,'nim.out'); rewrite(output);
assign (input, 'nim.out'); reset(input);
read(a);
if a=1 then
writeln('First')
else
if a=2 then
writeln('Second');


end.