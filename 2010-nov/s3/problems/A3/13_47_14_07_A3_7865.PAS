Program Z;
Var a,b,c:ARRAY [1..252] of longint;
Var i,n,j,k: integer;
Begin
assign(input, 'a3.in');
assign(output, 'a3.out');
reset(input);
rewrite(output);
read(input,n);
a[1]:=1;
b[1]:=1;
c[1]:=1;
For j:=3 to n do
begin
for i:=1 to 252 do c[i]:=0;
For i:=1 to 251 do
begin
c[i+1]:=(a[i]+b[i]+c[i]) div 10;
c[i]:=(a[i]+b[i]+c[i]) mod 10;
end;
For k:=1 to 252 do
begin
a[k]:=b[k];
b[k]:=c[k];
end;
end;
i:=252;
While c[i]=0 do
dec(i);
For k:=i downto 1 do
write(output, c[k]);
close(input);
close(output);
End.