uses
  SysUtils;
var
 n, i, j, res : longint;
 a : array [0..32] of integer;
 //c, b : array [0..32] of int64;
 o : int64;
begin
 reset(input,'teeth.in');
 rewrite(output,'teeth.out');

 res := 0;

 for i := 0 to 31 do
  read(a[i]);

 readln(n);

 for i := 1 to n do begin
   read(o);
   for j := 0 to 31 do
    if ((o shr j)and 1) = 1 then res := res + a[j];
   end;

  writeln(res);
 close(input);
 close(output);
end.











