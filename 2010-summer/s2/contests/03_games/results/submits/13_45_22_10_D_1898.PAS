var a,b,c,d,e,f:integer;
begin
assign (output,'nim.out'); rewrite(output);
assign (input, 'nim.in'); reset(input);
readln(c);
read(a,b,d,e,f);
if (c mod 2)=1 then
writeln('First')
else
writeln('Second');
end.