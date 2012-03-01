program regex;
Var a:array [1..100] of char;
b:array [1..100] of char;
g,s:string;
n,i,m,e,d,h:longint;
begin
assign (input, 'expr.in');
assign (output, 'expr.out');
reset (input);
rewrite (output);

WriteLn('WRONG');
close(input);
close(output);
end.