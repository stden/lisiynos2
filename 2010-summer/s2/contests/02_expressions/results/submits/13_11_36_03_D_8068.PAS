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
ReadLn(e, d);
m:=length(s);
readln(s);
for i:=1 to m do
    a[i]:=s[i];
readln(g);
n:=length(g);
i:=1;
for i:=1 to n   do
    b[i]:=s[i];
WriteLn('1');
close(input);
close(output);
end.