program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
  n,i:integer;
begin
  reset(input, 'c.in');
  rewrite(output, 'c.out');
  read(n);
  for i := 2 to n div 2 do
  begin
    if n mod i = 0 then
    begin
      write('NO',', ', i);
      halt;
    end;
  end;
  write('YES');
end.
