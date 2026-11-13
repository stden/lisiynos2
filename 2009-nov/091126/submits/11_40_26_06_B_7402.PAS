program dogd;
var a:array[1..100,1..100] of integer;
    b:array[1..1,1..100] of integer;
    n,i,j,k:integer;
begin
 assign(input,'color.in');
 reset(input);
 assign(output,'color.out');
 rewrite(output);
 readln(n);
  for i:=1 to n do
   for j:=1 to n do read(a[i,j]);
 writeln;
  for i:=1 to n do read(b[1,i]);
  for i:=1 to n do
   for j:=1 to n do
    if (a[i,j]=1) and (b[1,j]<>b[1,i]) then inc(k);
 writeln(k div 2);
 readln;
End.