{$APPTYPE CONSOLE}

Uses SysUtils;

Const
  TaskID = 'a3';

const
  nmax = 100;

var
  a: array [1 .. nmax, 1 .. nmax] of integer;
  b: array [1 .. nmax] of integer;
  c: array [1 .. nmax] of integer;
  n: integer;
  v1, v2: integer;

procedure ReadData;
var
  i, j: integer;
begin
  Reset(input, TaskID + '.in');
  read(n);
  assert((1 <= n) and (n <= nmax));
  for i := 1 to n do
    for j := 1 to n do
      read(a[i, j]);
  read(v1, v2);

  for i := 1 to n do
  begin
    for j := 1 to n do
      assert(a[i, j] = a[j, i]);
    assert(a[i, i] = 0);
  end;
  Close(input);
end;

procedure WriteAnswer;
var
  i, k: integer;
begin
  Rewrite(output, TaskID + '.out');
  writeln(b[v2]);
  if b[v2] = -1 then exit;
  if b[v2] <> 0 then
  begin
    c[1] := v2;
    k := 1;
    while c[k] <> v1 do
    begin
      for i := 1 to n do
        if (a[c[k], i] = 1) and (b[i] < b[c[k]]) then
        begin
          c[k + 1] := i;
          break;
        end;
      inc(k);
    end;
    for i := k downto 1 do
      write(c[i], ' ');
  end;
  Close(output);
end;

procedure Solve;
var
  i, j, k: integer;
begin
  for i := 1 to n do
    b[i] := -1;
  b[v1] := 0;
  for k := 0 to n - 1 do
    for i := 1 to n do
      if b[i] = k then
        for j := 1 to n do
          if (a[i, j] = 1) and (b[j] = -1) then
            b[j] := k + 1;
end;

begin
  ReadData;
  Solve;
  WriteAnswer;
end.
