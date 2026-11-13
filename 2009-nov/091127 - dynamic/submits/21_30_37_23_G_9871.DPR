{$apptype console}

var
  n, i: integer;
  k, c, z, _z: int64;

begin
  assign(input, 'g.in'); reset(input);
  assign(output, 'g.out'); rewrite(output);

  read(n, k);
  c := k - 1;
  z := 0;
  _z := k - 1;
  for i := 2 to n do begin
    c := c*k - z;
    z := _z;
    _z := c - z;
  end;
  writeln(c);
end.
