program substr;
var n,i,j:INTeger;
    s: string;
    f1:boolean;
begin
assign(input,'palin.in');
assign(output,'palin.out');
reset(input);
rewrite(output);
read(s);
for i:=1 to length(s) do begin
if (s[i]= ' ') then delete (s, i, 1); end;
n:=length(s);
for j:=1 to n do begin
 if s[j]=s[n-j+1] then
 f1:=true else f1:=false; end;
if f1=true then
write('YES') else write ('NO');
close(input);
close(output);
end.
