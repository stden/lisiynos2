program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var r,xp,yp,zp,x,y,z,k,i,n:integer;
begin
  reset(input,'flyfear.in');
  rewrite(output,'flyfear.out');
  read(r,xp,yp,zp);
  read(n);
  k:=0;
  for i:=1 to n do begin
    read(x,y,z);
    if r*r>(sqr(x-xp)+sqr(y-yp)+sqr(z-zp)) then inc(k);

  end;
  writeln(k);
end.
 