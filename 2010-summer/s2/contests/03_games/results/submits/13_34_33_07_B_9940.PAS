program qq;
var f:text;
    a:integer;
    l:byte;
    b:boolean;
procedure DFG(k:byte;m:integer;c:boolean);
var j:byte;
begin
if k<m then
  begin
  for j:=k downto 0 do
  begin
   if b then
   begin
   write(f,j+1);
   close(f);
   halt;
   end
   else  if j<> 0 then DFG(j,m-j,not c);
 end;
 end
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