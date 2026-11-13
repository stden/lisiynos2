program lol;
Var a:array [1..100] of char;
b:array [1..100] of char;
g,s:string;
n,i,m,e,k,d,h:longint;
begin
assign (input, 'candy.in');
assign (output, 'candy.out');
reset (input);
rewrite (output);
Readln(n, k);
if n = 2*k+1
then WriteLn(k)
else
if n mod 2 = 1 then Writeln (1) else
begin if n mod 4 = 2 then  WriteLn(2) else writeln(4) end;
close(input);
close(output);
end.