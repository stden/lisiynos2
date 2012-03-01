program Project1;
var s:string;
    q,k,y:integer;
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
  writeln(s);
end.