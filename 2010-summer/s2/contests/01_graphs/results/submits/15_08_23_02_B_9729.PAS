program komponenty_svysy;
var a: array[1..100, 1..100] of integer;
    m,n,i,j:INTEGER;
    L: REAL;
begin
assign(input,'tree.in');
assign(output,'tree.out');
reset(input);
rewrite(output);
read(n);
for i:=1 to n do
  for j:=1 to n do
  read(a[i,j]);
   l:=0;
for i:=1 to n DO
  for j:=1 to n do
  if a[i,j]=1 then L:=L+1;
  L:=L/2;
  if n=l+1 then
  write(output,'YES') else  write(output,'NO');
  end.



