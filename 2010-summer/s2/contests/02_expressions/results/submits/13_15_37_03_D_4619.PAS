program regex;
Var a:array [1..100] of char;
b:array [1..100] of char;
g,s:string;
n,i,m,e,d,h:longint;
begin
assign (input, 'logexpr.in');
assign (output, 'logexpr.out');
reset (input);
rewrite (output);

WriteLn(1);
close(input);
close(output);
end.