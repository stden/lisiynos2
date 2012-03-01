program B;
var l,k: integer;
begin
  assign(input,'candy.in');
  assign(output,'candy.out');
  reset(input);
  rewrite(output);
  Readln(l,k);
     if l <= (2*k +1) then
     writeln(k)
     else
     if k mod 2 = 1 then writeln(1) else
     begin
         if k mod 4 = 2 then  writeln(2)
         else writeln(4)
         end;
  close(input);
  close(input);
end.
