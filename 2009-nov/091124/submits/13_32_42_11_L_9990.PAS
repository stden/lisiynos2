program fib;
var a:array[0..45] of longint;
    i,n:longint;
begin
 assign(input,'fib.in');
 reset(input);
 assign(output,'fib.out');
 rewrite(output);
 readln(n);
 a[0]:=1;
 a[1]:=1;
  for i:=2 to n do a[i]:=a[i-1]+a[i-2];
 writeln(a[n]);
 readln;
End.