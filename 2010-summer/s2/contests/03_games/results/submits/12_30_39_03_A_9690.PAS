program lol;
Var a:array [1..50] of char;
b:array [1..50] of char;
g,s:string;
n,i,m,e,d,h:longint;
begin
assign (input, 'knight.in');
assign (output, 'knight.out');
reset (input);
rewrite (output);
Readln(n, m);
e:=(n+m-2) div 3;
if ((n+m-2) mod 3 <> 0)  then writeln(0) else
WriteLn(e);
close(input);
close(output);
end.