program repair;
{$APPTYPE CONSOLE}
var s:int64;
procedure myach(n, k:int64);
begin
 if k<n then begin
  myach(n, k+1);
  myach(n, k+2);
  myach(n, k+3);
 end;
 if k=n then s:=s+1;
end;
var a:int64;
begin
assign(input, 'c.in');
reset(input);
assign(output, 'c.out');
rewrite(output);
readln(a);
myach(a, 0);
writeln(s);
close(input);
close(output);
end.
