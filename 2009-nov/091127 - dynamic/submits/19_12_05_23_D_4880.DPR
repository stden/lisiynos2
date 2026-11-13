var
  n, i, j: integer;
  c: array[1..50, 1..50] of integer;

begin
  assign(input, 'd.in'); reset(input);
  assign(output, 'd.out'); rewrite(output);

  read(n);
  for i := 1 to n do
    for j := 1 to n do
      read(c[i, j]);

  for i := 1 to n do
    for j := 1 to n do begin
      if (i = 1) and (j > 1) then
        inc(c[i, j], c[i, j - 1]);
      if (i > 1) and (j = 1) then
        inc(c[i, j], c[i - 1, j]);
      if (i > 1) and (j > 1) then begin
        if c[i - 1, j] > c[i, j - 1] then
          inc(c[i, j], c[i - 1, j])
        else
          inc(c[i, j], c[i, j - 1]);
      end;
    end;

  writeln(c[n, n]);
end.