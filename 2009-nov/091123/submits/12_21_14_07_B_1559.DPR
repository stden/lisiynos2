program fib;

{$APPTYPE CONSOLE}

uses
  SysUtils;
 var q,f,g,res,w:extended;
  i,n:longint;
begin
 reset(input,'b.in');
 rewrite(output,'b.out');
 read(n);n:=n-1;f:=((1+sqrt(5))/2);q:=1;  res:=1;
  for i := 1 to n+1 do
    q:=q*f;
 res:=(1/sqrt(5))*q;
           w:=1;
 g:=((1-sqrt(5))/2);
   for i:=1 to n+1 do
    w:=w*g;
 res:=res-(1/sqrt(5))*w;
 write(res:0:0);
end.
