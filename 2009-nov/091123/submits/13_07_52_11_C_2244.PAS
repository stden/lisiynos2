{$N+}
program z;
var n,i:longint;
    a:array[1..100] of extended;
begin
 assign(input,'c.in');
 reset(input);
 assign(output,'c.out');
 rewrite(output);
 readln(n);
 a[1]:=1;
 a[2]:=2;
 a[3]:=4;
  for i:=4 to n do a[i]:=a[i-1]+a[i-2]+a[i-3];
 writeln(a[n]:0:0);
 readln;
End.
