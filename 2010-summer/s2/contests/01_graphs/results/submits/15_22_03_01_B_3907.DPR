Program B;
Var N,i,j,l: INTEGER;
Var a: ARRAY [1..100, 1..100] of INTEGER;
Begin
assign(input, 'Tree.in');
assign(output, 'Tree.out');
reset(input);
rewrite(output);
l:=0;
Read (N);
For i:=1 to N do
Begin
For j:=1 to N do
Begin
read (a[i,j]);
If a[i,j]=1 then l:=l+1;
End;
End;
If l/2=N-1 then writeln ('YES') else writeln ('NO');
close(input);
close(output);
End.

