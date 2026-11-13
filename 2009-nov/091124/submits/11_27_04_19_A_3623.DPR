program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
n,i,j:integer;

begin
assign(input,'simple.in');
reset(input);
assign(output, 'simple.out');
rewrite(output);

read(n);

for i:= 2 to round(sqrt(n)) do
  if (n mod i) = 0 then begin
  writeln('1');
  exit;
  end;
writeln('0');
end.
