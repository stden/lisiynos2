program d;

var n,i,j:integer;
    a:array[1..50,1..50] of integer;

function m(a,b:longint):longint;
begin
if a>b then m:=a
else m:=b;
end;

begin
assign(input,'d.in');
reset(input);
assign(output,'d.out');
rewrite(output);
readln(n);
for i:=1 to n do
  for j:=1 to n do
    read(a[i,j]);

for i:=2 to n do
a[1,i]:=a[1,i-1]+a[1,i];

for i:=2 to n do
a[i,1]:=a[i-1,1]+a[i,1];
for i:=2 to n do
  for j:=2 to n do
  a[i,j]:=max(a[i,j-1],a[i-1,j])+a[i,j];


writeln(a[n,n]);
readln;
End.

