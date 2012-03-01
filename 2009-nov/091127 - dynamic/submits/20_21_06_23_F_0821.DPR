var
  n, i, ans: integer;
  c: array[1..30] of integer;

begin
  assign(input, 'f.in'); reset(input);
  assign(output, 'f.out'); rewrite(output);

  read(n);

  c[1] := 2;
  c[2] := 4;
  c[3] := 7;
  for i := 4 to n do
    c[i] := c[i - 1] + c[i - 2] + c[i - 3];

  ans := 1 shl n - c[n];
  writeln(ans);
end.