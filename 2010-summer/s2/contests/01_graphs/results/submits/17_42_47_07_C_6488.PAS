program qwqw;
type mass=array[1..1000] of integer;
var qwe,qwe2:mass;
    q,n,m,w,e,r:integer;
    f:text;
    c:boolean;
begin
assign(f,'cycle.in');
reset(f);
read(f,n);
read(f,m);
for q:=1 to m do
begin
read(f,qwe[q]);
read(f,qwe2[q]);
end;
close(f);
assign(f,'cycle.out');
rewrite(f);
for q:=1 to m do
   for w:=1 to m do
   if qwe[q]=qwe2[w] then  c:=true;
if not c then writeln(f,'NO');
close(f);
end.
