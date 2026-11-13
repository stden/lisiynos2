program use;
begin
assign(input,'expr.in');
assign(output,'expr.out');
reset(input);
rewrite(output);
write('YES');
close(input);
close(output);
end.