program Project1;
var s,t,l:string;
    q,k,y:byte;
    f:text;
begin
assign(f,'palin.in');
reset(f);
readln(f,s);
  k:=1;
for q:=1 to length(s) do
begin
if s[q]<>' ' then l:=l+s[q];
end;
  for q:= 1 to length(l) do
  begin
   t:=t+l[length(l)+1-q];
  end;
  assign(f,'palin.out');
  rewrite(f);
  if t=l then write(f,'YES')
  else write(f,'NO');
  close(f);
end.