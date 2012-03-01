program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
  n,i:longint;
  s: array [0..40] of int64;
begin
  reset(input, 'ñ.in');
  rewrite(output, 'ñ.out');
  read(n);

  s[0]:=1;
  s[1]:=1;
  s[2]:=2;

  for i := 3 to n do
  s[i]:=s[i-1]+s[i-2]+s[i-3];

  write(s[n]);
end.
