{$APPTYPE CONSOLE}
uses
  SysUtils,math;
var
 n,i,j,o,p:longint;
 max,s,r,cx,cy:extended;
x,y:array[1..30000] of extended;
//a:array[1..30000,1..30000] of extended;
function ss(x4,y4,x5,y5:extended):extended;
begin
ss:=sqrt(sqr(x4-x5)+sqr(y4-y5));
end;

begin
 reset(input,'garden.in');
 rewrite(output,'garden.out');
 readln(n);
 for i:=1 to n do
 readln(x[i],y[i]);
 max:=0;
 for i:=1 to n do
  for j:=1 to n do begin
   if i<>j then s:=ss(x[i],y[i],x[j],y[j]) else s:=-1;
   if s>max then begin
   o:=i;
   p:=j;
   max:=s;
  end;
 end;
 r:=max/2;
 if x[o]>x[p] then cx:=(x[o]-x[p])/2+x[p] else
 if x[o]<x[p] then cx:=(x[p]-x[o])/2+x[o] else
 cx:=x[o];
 if y[o]>y[p] then cy:=(y[o]-y[p])/2+y[p] else
 if y[o]<y[p] then cy:=(y[p]-y[o])/2+y[o] else
 cy:=y[o];
 //writeln(x[o]:5:5,' ',y[o]:5:5,' ',x[p]:5:5,' ',y[p]:5:5);
 writeln(r:5:5);
 writeln(cx:5:5);
 writeln(cy:5:5);
 close(input);
 close(output);
end.
