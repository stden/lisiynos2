program aaa;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var n, i, r, x, y, m : longint;
 a : array [0..100] of longint;
begin
 reset(input, 'domino.in');
 rewrite(output, 'domino.out');
 readln(m);
 if n = 0 then write(1) else begin for i := 0 to m do
  a[i] := m + 2;
 readln(n);
 for i := 1 to n do begin
  readln(x, y);
  dec(a[x]);
  dec(a[y]);
 end;
 r := 0;
 for i := 0 to m do
  if a[i] mod 2 = 1 then inc(r);
 if r mod 2 = 1 then inc(r);
 r := r div 2;
 writeln(r);
 end;
end.
