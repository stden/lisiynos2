program repair;
{$APPTYPE CONSOLE}
var i:integer;
 n,a,b,c:int64;
begin
assign(input, 'b.in');
reset(input);
assign(output, 'b.out');
rewrite(output);
i:=1;
b:=1;
a:=0;
readln(n);
for i:=1 to n-1 do begin
n:=b;
b:=b+a;
a:=n;
end;
write(b);
close(input);
close(output);
end.
