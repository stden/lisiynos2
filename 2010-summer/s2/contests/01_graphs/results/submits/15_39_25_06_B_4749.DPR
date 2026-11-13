program tree;
var
a:array[1..100] of integer;
b:array[1..100, 1..100] of integer;
s, n, i, j: integer;
 begin
 assign(input, 'tree.in');
 assign(output, 'tree.out');
 reset(input);
 rewrite(output);
s :=0;
   n := 0;
 readln(n);
 for i := 1 to n do
 for j:= 1 to n do
  begin
 read (b[i,j]);
 end;
   for i := 1 to n do
 for j:= 1 to n do
  begin
 if b[i,j] = 1 then
 s:= s +1;
 end;
  if (s/2)+1 = n
  then write('YES')
  else write ('NO');
close(input);
close(output);
end.

