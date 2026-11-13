program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var f,t:text;
a,b:int64;
begin
  assign(f,'z.in');
  assign(t,'z.out');
  reset(f);
  rewrite(t);
  read(f,a);
  read(f,b);
  a:=a+b;
  writeln(t,a);
  close(f);
  close(t);
end.
 