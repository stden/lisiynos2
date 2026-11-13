const p=38;
      t=983;
var
i,j:integer;
f:text;
s:char;
begin
assign(f,'in.txt');
append(f);
writeln(f,'');
for i:=1 to p do
  for j:=1 to p do
    begin
      write(f,random(t),' ');
      if j=p then writeln(f,'');
    end;
close(f);
end.