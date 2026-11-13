program z;
var a:array[1..7] of longint;
    n,i,j,k:longint;
    s:string;
begin
 assign(input,'stuffbag.in');
 reset(input);
 assign(output,'stuffbag.out');
 rewrite(output);
 readln(n);
  for i:=1 to n do begin
   readln(s);
    if s='APTECHKA' then inc(a[1]);
    if s='AVTOMAT' then inc(a[2]);
    if s='NOGH' then inc(a[3]);
    if s='NOSKI' then inc(a[4]);
    if s='PORTIANKI' then inc(a[5]);
    if s='SCHETKA' then inc(a[6]);
    if s='SHLEM' then inc(a[7]);
  end;
  for i:=1 to 7 do
   for j:=1 to a[i] do
    if i=1 then writeln('APTECHKA') else
    if i=2 then writeln('AVTOMAT') else
    if i=3 then writeln('NOGH') else
    if i=4 then writeln('NOSKI') else
    if i=5 then writeln('PORTIANKI') else
    if i=6 then writeln('SCHETKA') else
    if i=7 then writeln('SHLEM');
 readln;
End.