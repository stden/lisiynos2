{$apptype console}

var
  k, x, y: integer;
  d: array[0..17, -17..17, -17..17] of integer;

function rec(k, x, y: integer): integer;
begin
  if (abs(x) > 17) or (abs(y) > 17) or (k < 0) then begin
    rec := 0;
    exit;
  end else
    if d[k, x, y] = -1 then begin
      d[k, x, y] := 0;
      inc(d[k, x, y], rec(k - 1, x - 1, y));
      inc(d[k, x, y], rec(k - 1, x, y - 1));
      inc(d[k, x, y], rec(k - 1, x + 1, y));
      inc(d[k, x, y], rec(k - 1, x, y + 1));
    end;
  rec := d[k, x, y];
end;

begin
  assign(input, 'e.in'); reset(input);
  assign(output, 'e.out'); rewrite(output);

  for k := 0 to 17 do
    for x := -17 to 17 do
      for y := -17 to 17 do
        d[k, x, y] := -1;
  d[0, 0, 0] := 1;

  read(k, x, y);
  writeln(rec(k, x, y));
end.

