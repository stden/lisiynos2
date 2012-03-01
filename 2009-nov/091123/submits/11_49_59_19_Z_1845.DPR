program B;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
a,c:integer;
begin
assign(input, 'z.in');
reset(input);
assign(output, 'z.out');
rewrite(output);
read(a,c);
writeln(a+c);
close(input);
close(output);
end.

