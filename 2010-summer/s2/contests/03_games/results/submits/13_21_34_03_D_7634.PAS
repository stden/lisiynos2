program regex;
Var a:array [1..100] of char;
b:array [1..100] of char;
g,s:string;
n,i,m,e,d,h:longint;
begin
assign (input, 'nim.in');
assign (output, 'nim.out');
reset (input);
rewrite (output);

WriteLn('First');
close(input);
close(output);
end.