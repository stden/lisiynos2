program qq;
var f:text;
    a,l:integer;
    b:boolean;
procedure DFG(k,m:integer;c:boolean);
var j:integer;
begin
if k<m then
  for j:=k downto 0 do
   if b then
   begin
   write(f,j+1);
   close(f);
   halt;
   end
   else  if j<> 0 then DFG(j,m-j,not c);
else
if not c Then b:=true;
end;

begin
assign(f,'candy.in');
reset(f);
read(f,a,l);
close(f);
assign(f,'candy.out');
rewrite(f);
if a<=l then write(f,l)
else begin
DFG(l,a,false);
if not b then write(f,'0');
end;
close(f);
end.