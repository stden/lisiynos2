Program mostik;
{uses crt;   }
var i,j,k,l,n,m:longint;
    g:array[1..100,1..100] of integer;
    h:array[1..100] of integer;
begin
assign(input,'color.in');
reset(input);
assign(output,'color.out');
rewrite(output);
readln(l);
m:=0;
for i:=1 to l do
 begin
 for j:=1 to l do
  begin
  read(g[i,j]);
  end;
 end;
for i:=1 to l do
 read(h[i]);
for i:=1 to l do
 begin
 for j:=1 to l do
  begin
  if ((g[i,j]=1) and (h[i]<>h[j])) then m:=m+1;
  end;
 end;
m:=m div 2;
writeln(m);
{readkey;   }
end.