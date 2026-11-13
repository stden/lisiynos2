
Var 
n:longint;
begin
assign (input, 'nim.in');
assign (output, 'nim.out');
reset (input);
rewrite (output);
read(n);
if n=1   then
WriteLn('First') else writeln ('Second');
close(input);
close(output);
end.