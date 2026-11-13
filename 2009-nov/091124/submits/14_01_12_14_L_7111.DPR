program l;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  math;

var
  r,x1,y1,z1:extended;
  x: array[1..100] of extended;
  y: array[1..100] of extended;
  z: array[1..100] of extended;
  i,j,n,k,c:integer;
begin
  reset(input,'flyfear.in');
  rewrite(output,'flyfear.out');
  readln(r);
  readln(x1,y1,z1);
  readln(n);
  c:=0;
  for i:=1 to n do begin
    readln(x[i],y[i],z[i]);
    if sqr(r)-(sqr(x[i]-x1)+sqr(z[i]-z1)+sqr(y[i]-y1))>=0 THEN inc(C);

  end;
     write(c);


end.
 