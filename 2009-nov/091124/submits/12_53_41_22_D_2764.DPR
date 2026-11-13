uses
  SysUtils;
var
 n, i, j, res : longint;
 a : array [0..32] of integer;
 c : array [0..32] of int64;

begin
 reset(input,'teeth.in');
 rewrite(output,'teeth.out');

 res := 0;

 for i := 0 to 31 do
  read(a[i]);

 readln(n);

  for i := 1 to n do
   read(c[i]);

 for i := 1 to n do
  for j := 0 to 31 do
   if c[i] = int64(1) shl (j) then res := res + a[j];

  {for i := 23 to 32 do
  writeln(i, ' ', a[i]);}
  writeln(res);
 close(input);
 close(output);
end.
