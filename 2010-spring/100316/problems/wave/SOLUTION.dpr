program way;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  n, i, j, a, b: integer;
  matrix: array [1..100,1..100] of integer;
  need: array [1..100] of boolean;

function countway(a,b:integer):integer;
var
  i, pr, min: Integer;
  r: boolean;
begin
  need[a] := false;
  r := false;
  if a<>b then
  begin
    for i := 1 to n do
      if matrix[a][b] = 1 then
      begin
        r := true;
        break;
      end;
    if r then
      countway := 1
    else
    begin
      min := 100;
      for i := 1 to n do
      begin
        if need[i] then
        begin
          pr := countway(i,b);
          if min > pr then
            min := pr;
        end;
      end;
      countway := pr+1;
    end;
  end
  else
  begin
    countway := 0;
  end;
end;

begin
  assign(input,'wave.in');
  reset(input);
  readln(n);
  for i := 1 to n do
    need[i] := true;
  for i := 1 to n do
    for j := 1 to n do
      read(matrix[i][j]);
  readln(a,b);
  close(input);
  assign(output,'wave.out');
  rewrite(output);
  write(countway(a,b));
  close(output);
end.
