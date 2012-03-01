begin
assign(output,'expr.out'); rewrite(output);
write('WRONG');
close(output);
end.