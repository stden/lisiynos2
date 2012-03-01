uses
  SysUtils;
var
 n, i, j, res : longint;
 a : array [0..32] of integer;
 b, c : array [0..32] of int64;

begin
 reset(input,'teeth.in');
 rewrite(output,'teeth.out');

 res := 0;

 for i := 1 to 32 do begin
  read(a[i]);
  b[i - 1] := int64(1) shl (i - 1);
 end;
 b[32] := int64(1) shl (32);
 readln(n);

  for i := 1 to n do
   readln(c[i]);

 for i := 1 to n do
  for j := 0 to 32 do
   if c[i] = b[j] then res := res + a[j];

  writeln(res);
 close(input);
 close(output);
end.
