{$APPTYPE CONSOLE}
uses SysUtils;

var n, i, j, m : longint;
 a : array [1..10000, 1..2] of integer;
 res : array [1..100] of longint;

begin
 reset(input, 'light.in');
 rewrite(output,'light.out');
 readln(n, m);

 for i := 1 to m do begin
   readln(a[i][1], a[i][2]);
   inc(res[a[i][1]]);
   inc(res[a[i][2]]);
  end;

 for i := 1 to n do
  write(res[i],' ');
end.
