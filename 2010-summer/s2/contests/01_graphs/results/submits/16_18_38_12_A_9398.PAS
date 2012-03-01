program matrix;
var a,v,u,n:integer;
i,j:array [1..100,1..100] of integer;
begin
assign(input,'tree.in');
assign(output,'tree.out');
reset(input);
rewrite(output);
read(a);
write(a);
close(input);
close(output);
end.
