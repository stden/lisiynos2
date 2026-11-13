program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var w1,w2,a1,a2,t:real;
begin
  reset(input,'sun.in');
  rewrite(output,'sun.out');
  read(w1,w2,a1,a2);
  t:=(a2-a1)/(w1-w2);
  writeln(t:0:2);
end.
 