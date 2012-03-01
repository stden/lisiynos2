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
if mod k = 1 then writeln(1) else 
writeln( k+1);

 close(input);
 close(input);
end.
