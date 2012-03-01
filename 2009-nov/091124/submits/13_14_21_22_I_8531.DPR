uses
  SysUtils;
var
 n, i, j, k : longint;
 a : array [1..100000] of string;
 b : array [1..100000] of byte;
 s : string;
begin
 reset(input,'stuffbag.in');
 rewrite(output,'stuffbag.out');
 readln(n);

 for i := 1 to n do begin
  readln(s);
  a[i] := s;
  if s = 'APTECHKA' then b[i] := 1;
  if s = 'AVTOMAT' then b[i] := 2;
  if s = 'NOGH' then b[i] := 3;
  if s = 'NOSKI' then b[i] := 4;
  if s = 'PORTIANKI' then b[i] := 5;
  if s = 'SCHETKA' then b[i] := 6;
  if s = 'SHLEM' then b[i] := 7;
 end;

 for i := 1 to n div 2 do
  for j := 1 to n - 1 do
   if b[j] > b[j + 1] then begin
    k := b[j];
    b[j] := b[j + 1];
    b[j + 1] :=k;
    s := a[j];
    a[j] := a[j + 1];
    a[j + 1] := s;
   end;

 for i := 1 to n do
  writeln(a[i]);

 close(input);
 close(output);
end.
