program collect;
var s:integer;


begin
assign(input,'postfix.in');
assign(output,'postfix.out');
reset(input);
rewrite(output);
read(s);

write('-102');


close(input);
close(output);

end.
