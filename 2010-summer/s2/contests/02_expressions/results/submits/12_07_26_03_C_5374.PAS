program lexem;
Var a:array [1..100] of char;
s:string;
n,i:longint;
begin
assign (input, 'lexem.in');
assign (output, 'lexem.out');
reset (input);
rewrite (output);
read(s);
n:=length(s);
for i:=1 to (n-1)   do
    a[i]:=s[i];
for i:=1 to (n-1) do
begin
if (a[i]='/') or (a[i]='*')  or (a[i]='+') or (a[i]= '-')
then
begin
writeln;
writeln (a[i]);
end
else
begin
if (a[i]=')') or (a[i]=')') then writeln (a[i])
else
write (a[i]);
end;
end;
close(input);
close(output);
end.