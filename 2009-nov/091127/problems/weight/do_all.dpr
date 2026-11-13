{$APPTYPE CONSOLE}

var i : integer;
begin
  Rewrite(Output,'03');
  writeln(100000);
  for i:=1 to 100000 do 
    writeln(random(10000)+1,' ',random(10000)+1);
  Rewrite(Output,'04');
  writeln(100000);
  for i:=1 to 100000 do 
    writeln(random(10000)+1,' ',random(1000)+1);
  Rewrite(Output,'05');
  writeln(100000);
  for i:=1 to 100000 do 
    writeln(random(100)+1,' ',random(100)+1);
  // Лёгкие гири, прочные крючки
  Rewrite(Output,'06');
  writeln(100000);
  for i:=1 to 100000 do 
    writeln(random(100)+1,' ',random(10000)+1);
end.