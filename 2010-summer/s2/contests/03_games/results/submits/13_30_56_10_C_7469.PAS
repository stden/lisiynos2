var a,b:integer;
begin
assign (output,'checkers.out'); rewrite(output);
assign (input, 'checkers.in'); reset(input);
readln;
read(a,b);
if a=b+1 then
writeln('Second')
else
writeln('First');


end.