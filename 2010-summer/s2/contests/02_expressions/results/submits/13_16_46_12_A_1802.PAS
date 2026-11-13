program D;
begin
assign(input,'D.in');
assign(output,'D.out');
reset(input);
rewrite(output);
write('WRONG');

close(input);
close(output);
end.