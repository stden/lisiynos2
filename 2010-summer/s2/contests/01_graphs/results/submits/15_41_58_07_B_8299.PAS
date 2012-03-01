program qqq;
var
    f:text;
    q,w,g,e,n:integer;
begin
assign(f,'tree.in');
reset(f);
read(f,n);
for q:=1 to n do
begin
 for w:= 1 to n do
 begin
  read(f,g);
  if g=1 then e:=e+1;
 end;
 end;
 close(f);
 assign(f,'tree.out');
 rewrite(f);
if n-1=e/2 then writeln(f,'YES')
else writeln(f,'NO');
close(f);
end.
