program tree;
 type tm = array[1..100,1..100] of integer;
 var b:tm;
s, n, i, j: integer;
 begin
 assign(input, 'tree.in');
 assign(output, 'tree.out');
 reset(input);
 n := 0;
 readln(n);
 s :=0;
 for i := 1 to n do
 for j:= 1 to j do
  begin
 read (b[i,j]);
 end;
   for i := 1 to n do
 for j:= 1 to j do
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

