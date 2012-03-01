uses crt;
var a,b,c,d,e,i,v,u,n:integer;
f1,f2:text;
inp:array[1..100,1..100] of integer;
begin
assign(f1,'tree.in');
assign(f2,'tree.out');
reset(f1);
rewrite(f2);
read(f1,n);
for a:=1 to n do
for b:=1 to n do
read(f1,inp[a,b]);
for a:=1 to n do
begin
writeln;
for b:=1 to n do
write(inp[a,b]);
end;
writeln;
for i:=1 to n do
for e:=1 to n do
begin
if (inp[i,e]=1) then
if ((i<n-1) and (inp[i+2,e]=0)) or ((i>2) and (inp[i-2,e]=0)) or ((e>2) and (inp[i,e-2]=0)) or ((e<n-1) and (inp[i,e+2]=0)) or
((i>1) and (e>1) and (inp[i-1,e-1]=0)) or ((i>1) and (e<n) and (inp[i-1,e+1]=0))
or ((i<n) and (e<n) and (inp[i+1,e+1]=0)) or ((i<n) and (e>1) and (inp[i+1,e-1]=0)) then
begin
writeln (i,' ',e);
clrscr;
d:=d-1;
end
else
begin
clrscr;
d:=d+1;
end;
end;
if d>=0 then writeln('YES')
else
writeln('NO');
readln;
end.