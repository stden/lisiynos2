{$APPTYPE CONSOLE}
var i:integer;
begin
  assign(output,'02'); rewrite(output);
  writeln(99-13+1);
  for i:=13 to 99 do
    writeln( i );
end.