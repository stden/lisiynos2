type
  integer = longint;

var
  tests: integer = 4;

procedure open;
var
  fn: string;
begin
  inc(tests);
  fn := chr(ord('0') + tests div 10) + chr(ord('0') + tests mod 10);
  assign(output, fn);
  rewrite(output);
end;

procedure close;
begin
  System.close(output);
end;

var
  i, j: integer;

begin
  randseed := 566;

  open;
  writeln(25);
  for i := 1 to 10 do
    writeln(5 + i div 2);
  for i := 12 downto 8 do
    writeln(-i);
  for i := 1 to 10 do
    writeln(4 + i div 2);
  close;

  open;
  writeln(100);
  for i := 1 to 40 do
    writeln(random(10) + 90);
  for i := 1 to 30 do
    writeln(-(95 + i));
  for i := 1 to 30 do
    writeln(random(30) + 90);
  close;

  open;
  writeln(239);
  for i := 39 downto 1 do
    writeln(100000 - random(10));
  for i := 1 to 20 do
    writeln(-(100000 + 13 - i));
  for i := 1 to 180 do
    writeln(100000 - random(100));
  close;

  open;
  writeln(100000);
  for j := 1 to 100 do
  begin
    for i := 1 to 600 do
      writeln(100000 - random(300));
    for i := 1 to 400 do
      writeln(-(100000 - 250 + i));
  end;
  close;

  open;
  writeln(100000);
  for j := 1 to 10 do
  begin
    for i := 1 to 7000 do
      writeln(99000 - random(6000));
    for i := 1 to 3000 do
      writeln(-(94000 + 3000 * j + i));
  end;
  close;

  open;
  writeln(100000);
  for i := 1 to 100000 do
    writeln(1);
  close;

  open;
  writeln(100000);
  for i := 1 to 100000 do
    writeln(100000);
  close;

  open;
  writeln(100000);
  for i := 1 to 50000 do
  begin
    writeln(1);
    writeln(-1);
  end;
  close;

  open;
  writeln(100000);
  for i := 1 to 50000 do
  begin
    writeln(i);
    writeln(-i);
  end;
  close;

  open;
  writeln(100000);
  for i := 1 to 25000 do
  begin
    writeln(i);
    writeln(i);
    writeln(i);
    writeln(-i - 1);
  end;
  close;

  open;
  writeln(100000);
  for j := 1 to 25000 do
  begin
    i := random(100000) + 1;
    writeln(i);
    writeln(i);
    writeln(i);
    writeln(-i - 1);
  end;
  close;

  open;
  writeln(100000);
  for j := 1 to 25000 do
  begin
    i := random(100000) + 1;
    writeln(i);
    writeln(i);
    writeln(j);
    writeln(-i - 1);
  end;
  close;
end.
