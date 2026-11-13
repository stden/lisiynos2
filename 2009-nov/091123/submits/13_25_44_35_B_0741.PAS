{$N+}
Program z;
Var n,j:Longint;
    a:array[1..100] of Extended;
Begin
 Assign(input,'b.in');
 Reset(input);
 Assign(output,'b.out');
 Rewrite(output);
 Readln(n);
 a[1]:=1;
 a[2]:=1;
  For j:=3 to n do a[j]:=a[j-1]+a[j-2];
 Writeln(a[n]:0:0);
 Readln;
End.