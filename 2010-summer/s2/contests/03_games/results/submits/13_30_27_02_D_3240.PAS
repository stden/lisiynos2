var n, m, k,i: integer;
begin
assign(input,'nim.in');
assign(output,'nim.out');
reset(input);
rewrite(output);
read(n);
if n<>0 then
writeln('First');
close(input);
close(output);
end.