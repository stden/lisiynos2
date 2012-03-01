program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const g=9.8;
var h,u,v,x,x0,r:int64;
begin
  reset(input,'airgun.in');
  rewrite(output,'airgun.out');
  read(h,u,v,x,x0,r);

  if (2*v*u*(x0-x+r)+g*sqr((x0-x+r))>2*h*v*v) and
  (2*v*u*(x0-x-r)+g*sqr((x0-x-r))<2*h*v*v) then writeln('YES') else writeln('NO');
end.
 