{$APPTYPE CONSOLE}
var

a, b :longint;

begin
reset(input, 'Z.in');
rewrite(output,'Z.out');

read(a, b);
write(a + b);

end.
