Var 
n,a,i,c,e:longint;
begin
assign (input, 'nim.in');
assign (output, 'nim.out');
reset (input);
rewrite (output);
readln(n);
if n=1   then
WriteLn('First') else
begin
read(a,i);
c:=a xor i;
if c mod 2=0 then writeln('First') else
writeln ('Second');
end;
close(input);
close(output);
end.