var a,b,c,d,e,f:integer;
begin
assign (output,'nim.out'); rewrite(output);
assign (input, 'nim.in'); reset(input);
readln(c);
read(a,b,d,e,f);
if c=1 then
writeln('First');
if c=2 then
if a=b then
writeln('Second')
else
writeln('First');
if c=3 then
writeln('First');
end.