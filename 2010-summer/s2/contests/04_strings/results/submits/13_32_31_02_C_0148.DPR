program substr;
var n,i:INTeger;
    s: string;
    f1:boolean;
begin
assign(input,'palin.in');
assign(output,'palin.out');
reset(input);
rewrite(output);
read(s);
n:=length(s);
for i:=1 to length(s) do begin
while (s[i]= ' ') do begin delete (s, i, 1);
 if s[i]=s[n-i+1] then
 f1:=true else f1:=false; end;  end;
if f1=true then
write('Yes') else write ('No');
close(input);
close(output);
end.
