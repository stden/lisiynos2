{$APPTYPE CONSOLE}

Uses SysUtils;

Const FileName = 'f1';

var
  n, x, y, z, r : integer;

procedure ReadData;
begin
  Reset( input, FileName+'.in' );
  readln(x,y,z);
  readln(n);
  close(input);
end;

procedure WriteAnswer;
begin
  Rewrite( output, FileName+'.out' );
  writeln(r);
  close(output);
end;

procedure Solve;
var
  a: array [0..9] of boolean;
  len, i : integer;
  s: string;
begin
  s := inttostr(n);
  len := length(s);
  for i := 0 to 9 do
    a[i] := false;
  for i := 1 to len do
    a[strtoint(s[i])] := true;
  r := 0;
  for i := 0 to 9 do
    if a[i] and (i<>x) and (i<>y) and (i<>z) then
      inc(r);
end;

begin
  ReadData;
  Solve;
  WriteAnswer;
end.
