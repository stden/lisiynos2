{$APPTYPE CONSOLE}
var i:integer;
begin
  assign(output,'01'); rewrite(output);
  writeln(9);
  for i:=1 to 9 do
    writeln(i);
end.