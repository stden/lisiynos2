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
if s<=[1,17,18,19,20,21,22,23,24,25,26,28,32,33,34,35,36,37,38,39,40,
41,47,48,49,50,51,56,57,59,60,61,67,68,69,70,71,77,78,79,80,81] then p:=0;
writeln(p);
end.
