var a:integer;
b:string;
begin
assign (input,'checkers.in'); reset(input);
assign (output,'checkers.out'); rewrite(output);
readln(a);
if a=1 then
writeln('First')
else
writeln('Second')
end.