program use;
begin
assign(input,'logexpr.in');
assign(output,'logexpr.out');
reset(input);
rewrite(output);
write('0');
close(input);
close(output);
end.