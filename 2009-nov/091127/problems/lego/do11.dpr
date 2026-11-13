{$APPTYPE CONSOLE}

var i:integer;
begin
  Rewrite(Output,'11');
  writeln(1000);
  for i := 0 to 999 do
    writeln(1000,' ',0);
end.
