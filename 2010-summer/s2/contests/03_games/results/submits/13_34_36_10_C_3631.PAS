uses crt;
var a,b:integer;
begin
assign (output,'checkers.out'); rewrite(output);
assign (input, 'checkers.in'); reset(input);
readln;
read(a,b);
if a+1=b then
writeln('Second')
else
writeln('First');
end.