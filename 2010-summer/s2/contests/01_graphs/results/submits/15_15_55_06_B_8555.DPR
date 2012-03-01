program true;
 type tm = array[1..100,1..100] of integer;
 var mas:tm;
 n, i, j: byte;
 begin
 assign(input, 'tree.in');
 assign(output, 'tree.out');
 reset(input);
 readln(n);
 n := 0;
 for i:= 1 to n do
 begin
 read (mas[i,j]);
 if mas[i,j] = 1 then
 n:= n +1;
 end;
   rewrite(output);
   if n mod 2 = 0 then
  begin
  n:=n div 2;
  if n=n-1 then
  write('yes')
  else write ('NO');
end ;
end.

