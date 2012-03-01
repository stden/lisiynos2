var
 n, i: integer;
 c: array[1..70] of extended;

begin
  assign(input, 'b.in'); reset(input);
  assign(output, 'b.out'); rewrite(output);

  read(n);
  c[1] := 1;
  c[2] := 1;
  for i := 3 to n do
     c[i] := c[i- 1] + c[i - 2];
  writeln(c[n]:0:0);
end.