{$APPTYPE CONSOLE}
var i:integer;
begin
  assign(output,'04'); rewrite(output);
  writeln(3000-1000+1);
  for i:=1000 to 3000 do
    writeln( i );
end.