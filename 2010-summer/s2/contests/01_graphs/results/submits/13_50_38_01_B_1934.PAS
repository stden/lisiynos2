Program B;
Uses crt;
Var N,i,j,l: INTEGER;
Var a: ARRAY [1..100, 1..100] of INTEGER;
Begin
Clrscr;
assign(input, 'Tree.in');
assign(output, 'Tree.out');
reset(input);
rewrite(output);
l:=0;
Read (N);
Write (N);
Writeln;
For i:=1 to N do
Begin
For j:=1 to N do
Begin
a[i,j]:=0;
If (i=j+1) or (j=i+1) then a[i,j]:=1;
If a[i,j]=1 then l:=l+1;
Write(a[i,j],' ');
End;
Writeln;
End;
If l/2=N-1 then writeln ('Yes, you win') else writeln ('No, you lose');
close(input);
close(output);
End.

