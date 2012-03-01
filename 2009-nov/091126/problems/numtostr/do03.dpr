{$APPTYPE CONSOLE}
var i:integer;
begin
  assign(output,'03'); rewrite(output);
  writeln(100);
  for i:=1 to 100 do
    writeln(random(999999999)+1);
end.