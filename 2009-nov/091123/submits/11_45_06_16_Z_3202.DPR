program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
  i,j:integer;
  n,m,c: int64;

begin
  reset(input, 'z.in');
  rewrite(output, 'z.out');
  read(n,m);
  c:=n+m;
  write(c);
end.
