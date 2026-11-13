program Project1;
var s,t:string;
    q,k,y:byte;
    f:text;
begin
assign(f,'palin.in');
reset(f);
while not eof(f) do
  begin
    readln(f,s);
  end;
  k:=1;
while k<>0 do
  begin
  k := pos(' ',s);
  if (k>0) then   delete(s,k,1)
  end ;
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