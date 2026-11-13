program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
xp,yp,zp:extended;
r,n,i,j:integer;
x,y,z:array[1..1000]of extended;
begin
assign(input, 'flyfear.in');
reset(input);
assign(output, 'flyfear.out');
rewrite(output);

readln(r);
readln(xp,yp,zp);
readln(n);
for i:= 1 to n do
  readln(x[i],y[i],z[i]);

j:=0;
for i:= 1 to n do
if (sqr(xp-x[i])+sqr(yp-y[i])+sqr(zp-z[i]))<=sqr(r) then
  j:=j+1;
writeln(j);
end.
