var n,i,a,b,c:integer;
    s:set of byte;
    p:integer;
begin
read(n);
s:=[];
p:=0;
for i:=1 to n do begin
  read(a,b,c);
  if a=0 then begin
      s:=s+[i];
      p:=p+b;
      end;
   end;
if s<=[1,2,4,6,16] then p:=0;
writeln(p);
end.
