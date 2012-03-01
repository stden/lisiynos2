program lexem;
var n, p, pos ,i:longINT;
Var s:string;
begin
assign(input,'lexem.in');
assign(output,'lexem.out');
reset(input);
rewrite(output);
read(s);
n:=length(s);
i:=0;
pos:=1;
while pos<n do
begin
writeln(s[pos]);
pos:=pos+1; end;
close(input);
close(output);
end.




