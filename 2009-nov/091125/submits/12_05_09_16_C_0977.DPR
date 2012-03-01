program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
  n,i,g:integer;
begin
  reset(input, 'c.in');
  rewrite(output, 'c.out');
  read(n);
  g:=n div 2;
  for i := 2 to g do
  begin
    if n mod i = 0 then
    begin
      write('NO',',', i);
      halt;
    end;
  end;
  write('YES');
end.
