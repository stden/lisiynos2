var
  n, p: integer;
  ts: array[1..16, 0..16] of int64;

function s(n, p: integer): integer;
begin
  if ts[n, p] = -1 then
    if n = p then
      ts[n, p] := 1
    else
      if (p > n) or (p = 0) then
        ts[n, p] := 0
      else
        ts[n, p] := s(n - 1, p)*(n - 1) + s(n - 1, p - 1);
  s := ts[n, p];
end;

begin
  assign(input, 'h.in'); reset(input);
  assign(output, 'h.out'); rewrite(output);

  for n := 1 to 16 do
    for p := 1 to 16 do
      ts[n, p] := -1;

  read(n, p);
  writeln(s(n, p));
end.
