{$apptype console}

var
  n, i: integer;
  k, c, d1, d2, d, t: int64;

begin
  assign(input, 'g.in'); reset(input);
  assign(output, 'g.out'); rewrite(output);

  read(n, k);
  c := k - 1;
  d := 0;
  d1 := k - 1;
  d2 := (k - 1)*(k - 1);
  for i := 2 to n do begin
    c := c*k - d;
    t := d1+ d2;
    d := d1;
    d1 := d2;
    d2 := t;
  end;
  writeln(c);
end.
