{$apptype console}
var a,b,c:int64;
    n,i:longint;
Begin
 assign(input,'b.in');reset(input);
 assign(output,'b.out');rewrite(output);
 read(n);
  a:=1;
  b:=1;
   for i:=2 to n do
    begin
     c:=a+b;
     a:=b;
     b:=c;
    end;
write(a);
End.
