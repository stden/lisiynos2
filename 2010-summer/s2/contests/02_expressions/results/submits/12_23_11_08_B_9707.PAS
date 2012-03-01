program C;
var s,t:string;n,m,i:integer; r:boolean;
begin
assign(input,'regex.in');
assign(output,'regex.out');
reset(input);
readln(n,m);
readln(s);
read(t);
rewrite(output);
for i:=1 to m do
if t[i]<>'*' then if s[i]=t[i] then r:=true else
 begin
 r:=false;
 write('NO');
 break;
 end;
if r=true then write('YES');
close(input);
close(output);
end.