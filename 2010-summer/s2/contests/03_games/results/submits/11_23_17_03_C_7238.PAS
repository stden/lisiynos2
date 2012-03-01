program regex;
Var a:array [1..100] of char;
b:array [1..100] of char;
g,s:string;
n,i,m,e,d,h:longint;
begin
assign (input, 'checkers.in');
assign (output, 'checkers.out');
reset (input);
rewrite (output);
ReadLn(m);
Read(l,r);
If (l=r-1) then WriteLn('Second') else writeln ('First');
close(input);
close(output);
end.