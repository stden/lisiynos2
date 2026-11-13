Program kolor;

 Var
 n,i,k,j :integer;
 m:array[1..100, 1..100] of Integer;
 c:array[1..100] of Integer;


begin

 reset(input, 'color.in');
 rewrite(output, 'color.out');
 readln(n);
 for i := 1 to n do begin
  for j := 1 to n do
   read(m[i, j]);
  end;
 for i := 1 to n do
  read(c[i]);
 k := 0;
 for i := 2 to n do
  for j := 1 to i - 1 do
   if (m[i,j] = 1) and (c[i] <> c[j]) then inc(k);
 write(k);
end.
