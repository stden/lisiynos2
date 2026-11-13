program c;

{$APPTYPE CONSOLE}
uses
  SysUtils;
var a,i,j,h:integer;
    g:int64;
    s:array [0..50] of int64;
begin
reset(input,'c.in');
rewrite(output,'c.out');
read(a);

s[1]:=1;
s[0]:=1;
s[2]:=2;

for i:=3 to a do begin
s[i]:=s[i-1]+s[i-2]+s[i-3];
end;
write(s[a]);
end.
