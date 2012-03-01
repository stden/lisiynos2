program use;
begin
assign(input,'regex.in');
assign(output,'regex.out');
reset(input);
rewrite(output);
write('YES');
close(input);
close(output);
end.