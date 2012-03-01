uses crt;
var a,b,c,d,e,i,v,u,n:integer;
f1,f2:text;
tmp:string;
inp:array[1..100,1..100] of integer;
begin
clrscr;
assign(f1, 'tree.in'); reset(f1);
assign(f2, 'tree.out'); rewrite(f2);
read(f1,n);
for a:=1 to n do
begin
writeln;
readln;
for b:=1 to n do
begin
readln(f1,inp[a,b]);
write(inp[a,b]);
end;
end;
b:=0;
a:=0;
for a:=1 to n do
if (inp[a,a] + inp[a+1,a] + inp[a,a+1] + inp[a+1,a+1]) = 0 then
b:=1;
if b=1 then
writeln(f2,'NO')
else
writeln(f2,'YES');
readln;
end.