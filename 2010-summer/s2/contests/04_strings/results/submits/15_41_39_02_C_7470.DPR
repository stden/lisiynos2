program substr;
var n,i,j,k:INTeger;
    s: string;
    f1:boolean;
begin
assign(input,'palin.in');
assign(output,'palin.out');
reset(input);
rewrite(output);
read(s);
j:=1;
while j<=length(s) do
if s[j]<>' ' then j:=j+1 else delete (s, j, 1);
for i:=1 to length(s) div 2 do
if s[i]<>s[length(s)-i+1] then
begin
write ('NO'); halt(0);
end;
write('YES');
close(input);
close(output);
end.
