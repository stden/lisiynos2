program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var h,u,v,x,x0,r:integer;
g:real;
begin
assign(input,'airgun.in');
reset(input);
assign(output,'airgun.out');
rewrite(output);
g:=9.8;
read(h,u,v,x,x0,r);
if (2*v*u*(x0-x+r)+g*(x0-x+r)>2*h*v*v)and(2*v*u*(x0-x-r)+g*(x0-x-r)<2*h*v*v)
then
writeln('YES')
else
writeln('NO');
close(input);
close(output);
end.
 