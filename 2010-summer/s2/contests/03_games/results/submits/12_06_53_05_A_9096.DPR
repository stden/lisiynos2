program A;
var
r:integer;

begin
randomize;
assign(input,'knight.in');
assign(output,'knight.out');
reset(input);
rewrite(output);
random(10);
read(r);
writeln(r);
close(input);
close(output);
end.
