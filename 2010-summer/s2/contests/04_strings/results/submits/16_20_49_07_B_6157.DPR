program B;
var  t,k:string;
     i,q:LONGINT;
function l(v:string):integer;
var z:integer;
begin
for z:= length(v)-1 downto 1 do
if copy(v,1,z)=copy(v,length(v)+1-z,z) then
BEGIN
 l:=length(copy(v,1,z));
 EXIT;
END;
l:=0;
end;
begin
 reset(input,'pi.in');
 readln(t);
 rewrite(output,'pi.out');
 for i := 1 to length(t) do begin
q:=l(copy(t,1,i));
write(q,' ');
  end;
end.
