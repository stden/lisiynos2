program polin;
var s:string;
n,i,j,m,k,pos:integer;
a:array [1..255] of char;
b: array [1..255] of char;

begin
assign(input,'palin.in');
assign(output,'palin.out');
reset(input);
rewrite(output);
read(s);
n:=length(s);
m:=0;
k:=0;
for i:=1 to n do
begin
if s[i] <> ' ' then
 begin
a[pos]:=s[i];
inc(k);
end;

begin
inc(pos);
inc(k);
end;
end;

for j:=n downto 1 do
begin
if s[i]<> ' ' then
begin
b[pos]:=s[i];
pos:=pos-i;
             end;

pos:=pos-1
end;
n:=n+1;
for i:=1 to n-1 do
begin
j:=n-i;

if  a[i]=b[j] then inc(m);
end;

if m+k=n then write('YES') else write('NO');
close(input);
close(output);
end.
