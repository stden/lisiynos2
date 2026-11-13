{$APPTYPE CONSOLE}
var i:integer;
begin
  assign(output,'03'); rewrite(output);
  writeln(999-100+1);
  for i:=100 to 999 do
    writeln( i );
end.