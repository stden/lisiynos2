program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

VAR a,i:integer;
begin
assign(input, 'c.in');
reset(input);
assign(output, 'c.out');
rewrite(output);

read(a);

for i:= 2 to round(sqrt(a)) do
  if a mod i = 0 then begin
    writeln('NO,', i);
exit;
end;

writeln('YES');
end.
