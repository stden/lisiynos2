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
for i:=1 to n   do
    a[i]:=s[i];
    i:=1;
While a[i]<>'.' do
begin
case a[i] of
    '(' :begin writeln (a[i]);  end ;
    ')' :begin writeln; write(a[i]); end;
    end;
if (a[i]='/') or (a[i]='*')  or (a[i]='+') or (a[i]= '-')
then
    begin
     writeln;
     writeln (a[i]);

    end
    else
if (a[i]=')') or (a[i]= '(' )   then write

else
    write (a[i]);
    i:=i+1;
    end;
close(input);
close(output);
end.