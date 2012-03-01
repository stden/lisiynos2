program Project1;



var
  a,b,c :array[1..100000] of integer;
  i,j,n,m :integer;

begin
  reset(input, 'weight.in');
  rewrite(output, 'weight.out');
  readLn(n);
  readLn(a[1], c[1]);

  b[1] := 1;
  m := a[1];
  for i := 2 To n do begin
    readLn(a[i], c[i]);
    b[i] := b[i - 1] + 1;
    if (m > c[i]) then begin
      j := 1;
      while (j < i) and (m > c[i]) do begin
        dec(b[i]);
        m := m - a[j];
      end;
    end;
    m := m + a[i];
  end;
  m := 1;
  for i := 1 to n do
  if (b[i] > b[m]) then m := i;
  writeln(b[m]);
end.
