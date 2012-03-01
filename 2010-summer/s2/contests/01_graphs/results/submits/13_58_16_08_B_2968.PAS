program ko;
var i,j,n:integer; o:integer;
a:array [1..100,1..100] of integer;
begin
assign(input,'tree.in');
assign(output,'tree.out');
reset(input);
read(n);
for i:=1 to n do
  for j:=1 to n do
    read(a[i,j]);
rewrite(output);
o:=0;
for i:=1 to n do
  for j:=1 to n do
    if a[i,j]=1 then
      o:=o+1;
      o:= o div 2;
     if n=o+1 then write('YES') else write('NO');
end.