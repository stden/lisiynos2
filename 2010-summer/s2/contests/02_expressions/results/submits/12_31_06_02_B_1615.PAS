program regex;
var n, p, pos ,i, m,w:INTeger;
Var s,t:string;
begin
assign(input,'regex.in');
assign(output,'regex.out');
reset(input);
rewrite(output);
read(n);
read(m);
readln(s);
readln(t);
pos:=1; w:=0;
if n<m then i:=n else i:=m;
while pos<=1 do  begin
if not (s[pos]=t[pos]) and not (t[pos]='*') then w:=1;
if w=1 then write ('YES') else write('NO'); end;
end.