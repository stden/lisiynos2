{apptype console}

const
  inf = 1000000000;

var
  n, i, j, p, q, besti, bestj, bestp, bestq, bestsum, sum: integer;
  a: array[1..100, 1..100] of integer;
  s: array[0..100, 1..100] of integer;
  l: array[1..100] of integer;

begin
  assign(input, 'a.in'); reset(input);
  assign(output, 'a.out'); rewrite(output);

  read(n);
  for i := 1 to n do
    for j := 1 to n do
      read(a[i, j]);

  fillchar(s, sizeof(s), 0);
  for p := 1 to n do
    for i := 1 to n do
      s[p, i] := a[p, i] + s[p - 1, i];

  besti := 1;
  bestj := 1;
  bestp := 1;
  bestq := 1;
  bestsum := -inf;
  for p := 1 to n do
    for q := p to n do begin
      for i := 1 to n do
        l[i] := s[q, i] - s[p - 1, i];
      sum := 0;
      i := 1;
      for j := 1 to n do begin
        inc(sum, l[j]);
        if sum > bestsum then begin
          bestsum := sum;
          besti := i;
          bestj := j;
          bestp := p;
          bestq := q;
        end;
        if sum < 0 then begin
          sum := 0;
          i := j + 1;
        end;
      end;
    end;
  for p := bestp to bestq do begin
    for j := besti to bestj do
      write(a[p, j], ' ');
    writeln;
  end;
end.

