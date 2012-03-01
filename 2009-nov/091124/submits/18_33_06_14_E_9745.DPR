program e;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  a,b,c,d,t:extended;
begin
  reset(input,'sun.in');
  rewrite(output,'sun.out');
  read(a,b,c,d);
  t:=(d-c)/(a-b);
  write(t:0:2);
end.
 