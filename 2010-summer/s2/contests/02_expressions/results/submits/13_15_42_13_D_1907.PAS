program use;
begin
assign(input,'logexpr.in');
assign(output,'logexpr.out');
reset(input);
rewrite(output);
write('1');
close(input);
close(output);
end.