{$APPTYPE CONSOLE}
var i:integer;
begin
  assign(output,'02'); rewrite(output);
  writeln(1000);
  for i:=1 to 1000 do
    writeln(random(9999)+1);
end.