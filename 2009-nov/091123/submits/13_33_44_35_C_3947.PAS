{$N+}
Program c;
Var n,i:longint;
    a:array[1..100] of extended;
Begin
 Assign(input,'c.in');
 Reset(input);
 Assign(output,'c.out');
 Rewrite(output);
 Readln(n);
 a[1]:=1;
 a[2]:=2;
 a[3]:=4;
  For i:=4 to n do a[i]:=a[i-1]+a[i-2]+a[i-3];
 Writeln(a[n]:0:0);
 Readln;
End.
