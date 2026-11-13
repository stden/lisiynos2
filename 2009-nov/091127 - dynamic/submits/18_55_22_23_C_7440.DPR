var
  n, i: integer;
  c: array[1..40] of int64;

begin
  assign(input, 'c.in'); reset(input);
  assign(output, 'c.out'); rewrite(output);
 
  read(n);
  c[1] := 1;
  c[2] := 2;
  c[3] := 4;
  for i := 4 to n do
    c[i] := c[i - 1] + c[i - 2] + c[i - 3];

  writeln(c[n]);
end.