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
readln;
readln(s);
readln(t);
pos:=1; w:=0;
if n<m then i:=n else i:=m;
while pos<=i do  begin
if not (s[pos]=t[pos]) and not (t[pos]='*') then w:=1; pos:=pos+1; end;
if w=1 then write ('NO') else write('YES');
end.