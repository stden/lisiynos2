uses
  SysUtils;
var
 n, i, k, j : longint;
 a : array [1..100, 1..100] of longint;
 b, c : array [1..100] of longint;
begin
 reset(input,'unreal.in');
 rewrite(output,'unreal.out');

 readln(n);
 for i := 1 to n do begin
  for j := 1 to n - 1 do begin
    read(a[i][j]);
    b[i] := b[i] + a[i][j];
   end;
  end;

 for i := 1 to n do
  c[i] := i;

 for i := 1 to n do
  for j := 1 to n - 1 do
   if b[j] > b[j + 1] then begin
     k := b[j];
     b[j] := b[j + 1];
     b[j + 1] := k;
     k := c[j];
     c[j] := c[j + 1];
     c[j + 1] := k;
    end;

 writeln(c[1]);
 close(input);
 close(output);
end.
