{$apptype console}

var n, i, x, y: integer;
begin
   randomize;
   n := {random(99)+2}100;
   writeln(n);
   for i := 1 to n do begin
      x := random(20001) - 10000;
      y := random(20001) - 10000;
      writeln(x,' ',y);
   end;
end.