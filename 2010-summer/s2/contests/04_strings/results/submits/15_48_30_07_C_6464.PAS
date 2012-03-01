program Project1;
var s,t,l:string;
    q,y:byte;
    f:text;
begin
assign(f,'palin.in');
reset(f);
readln(f,s);
y:=length(s);
for q:=1 to y do
begin
if s[q]<>' ' then l:=l+s[q];
end;
y:=length(l);
  for q:= 1 to y do
  begin
   t:=t+l[y+1-q];
  end;
  assign(f,'palin.out');
  rewrite(f);
  if t=l then write(f,'YES')
  else write(f,'NO');
  close(f);
end.