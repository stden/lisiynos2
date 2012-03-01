{$APPTYPE CONSOLE}
var

s : array 1..1000000] of char;
q, i :longint;

begin
reset(input, 'Y.in'););
rewrite(output,'Y.out');
q := 0;
while not eof(input) do
 begin
   inc(q);
   read(s[q]);
 end;

 for i := q downto 1 do
  write(s[i]);


end.
