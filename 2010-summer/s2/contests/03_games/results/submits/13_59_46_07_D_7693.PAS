program qqq;
var a,q:integer;
    k,e:byte;
    asd:array[1..100] of integer;
    f:text;
begin
assign(f,'nim.in');
reset(f);
read(f,a);
for q:=1 to a do
 read(f,asd[q]);
close(f);
assign(f,'nim.out');
rewrite(f);
if a mod 2 =1 then write(f,'First');
if a mod 2 =0 then
begin
while (asd[q]=1) and (q<=a) do
q:=q+1;
if q-1= a then write(f,'First')
else write(f,'Second');
end;
close(f);
end.