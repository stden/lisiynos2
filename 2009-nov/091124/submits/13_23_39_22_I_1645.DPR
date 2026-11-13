uses
  SysUtils;
var
 n, i, j : longint;
 s : string;
 b : array [1..7] of longint;
begin
 reset(input,'stuffbag.in');
 rewrite(output,'stuffbag.out');
 readln(n);

 for i := 1 to n do begin
  readln(s);
  if s = 'APTECHKA' then inc(b[1]);
  if s = 'AVTOMAT' then inc(b[2]);
  if s = 'NOGH' then inc(b[3]);
  if s = 'NOSKI' then inc(b[4]);
  if s = 'PORTIANKI' then inc(b[5]);
  if s = 'SCHETKA' then inc(b[6]);
  if s = 'SHLEM' then inc(b[7]);
 end;

 for i := 1 to 7 do
  for j := 1 to b[i] do begin
   if i = 1 then writeln('APTECHKA');
   if i = 2 then writeln('AVTOMAT');
   if i = 3 then writeln('NOGH');
   if i = 4 then writeln('NOSKI');
   if i = 5 then writeln('PORTIANKI');
   if i = 6 then writeln('SCHETKA');
   if i = 7 then writeln('SHLEM');
  end;


 close(input);
 close(output);
end.
