program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
  n,i:integer;
begin
  reset(input, 'simple.in');
  rewrite(output, 'simple.out');
  read(n);
  for i := 2 to (n div 2) do
  begin
    if n mod i = 0 then
    begin
      write('1');
      halt;
    end;
  end;
    write('0');
end.
