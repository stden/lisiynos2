{$N+}
program z;
var n,i:longint;
    a:array[1..100] of extended;
begin
 assign(input,'b.in');
 reset(input);
 assign(output,'b.out');
 rewrite(output);
 readln(n);
 a[1]:=1;
 a[2]:=1;
  for i:=3 to n do a[i]:=a[i-1]+a[i-2];
 writeln(a[n]:0:0);
 readln;
End.