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
if s[q]<>' ' then l:=l+s[q];
  for q:= 1 to length(s) do
  begin
   t:=t+s[length(s)+1-q];
  end;
  assign(f,'palin.out');
  rewrite(f);
  if s=t then write(f,'YES')
  else write(f,'NO');
  close(f);
end.