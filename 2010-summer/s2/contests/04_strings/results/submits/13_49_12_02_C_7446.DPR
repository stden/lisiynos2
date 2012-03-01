program substr;
var n,i,k:INTeger;
    s: string;
    f1:boolean;
begin
assign(input,'palin.in');
assign(output,'palin.out');
reset(input);
rewrite(output);
read(s);
n:=length(s);
k:=0;
for i:=1 to length(s) do begin
while (s[i]= ' ') do begin delete (s, i, 1); k:=k+1; ;
 if s[i]=s[n-k-i+1] then
 f1:=true else f1:=false; end;  end;
if f1=true then
write('YES') else write ('NO');
close(input);
close(output);
end.
