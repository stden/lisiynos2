{$APPTYPE CONSOLE}

{ Алгоритм Флойда в чистом виде }

procedure solve;
var
  n, i, j, k: integer;
  mas: array [1 .. 50, 1 .. 50] of integer;
begin
  read(input, n);

  for j := 1 to n do
    for i := 1 to n do begin
      read(input, k);
      mas[j, i] := k;
    end;

  for i := 1 to n do
    mas[i, i] := 0;

  for k := 1 to n do
    for j := 1 to n do
      for i := 1 to n do 
        if mas[j, k] + mas[k, i] < mas[j, i] then
          mas[j, i] := mas[j, k] + mas[k, i];
  for j := 1 to n do begin
    for i := 1 to n do
      write(output, mas[j, i], ' ');
    writeln;
  end;
  writeln;
end;

var
  Test, Tests: integer;
begin
  Reset(input,'smallw.in');
  Rewrite(output,'smallw.out');
  read(input, Tests);
  for Test := 1 to Tests do
    Solve;
  close(input);
  close(output);
end.
