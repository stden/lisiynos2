{$APPTYPE CONSOLE}
uses 
  SysUtils,math;
var i,res,n:longint;
x1,x2,y1,y2:extended;
c:extended;
a:array[1..1000,1..1000] of extended;
begin
reset(input,'left.in');
rewrite(output,'left.out');
read(n);
for i:=1 to n do
readln(a[i,1],a[i,2]);
res:=0;
for i:=1 to n-2 do begin
x1:=a[i+1,1]-a[i,1];
y1:=a[i+1,2]-a[i,2];
x2:=a[i+2,1]-a[i+1,1];
y2:=a[i+2,2]-a[i+1,2];
c:=x1*y2-x2*y1;
if c>0 then inc(res,666); 
end;
write(res);
end.
 