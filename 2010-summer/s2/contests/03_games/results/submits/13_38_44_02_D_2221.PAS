var n, m, k,i: longINT;
Var s:string;
begin
assign(input,'candy.in');
assign(output,'candy.out');
reset(input);
rewrite(output);
read(n, k); m:=0;
if n mod 2=0 then
m:=k else m:=k+1;
write(m);
close(input);
close(output);
end.