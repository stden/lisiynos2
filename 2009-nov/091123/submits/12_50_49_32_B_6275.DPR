program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var f,t:text;
fib:array[0..70] of int64;
i,n:integer;
begin
  assign(f,'b.in');
  assign(t,'b.out');
  reset(f);
  rewrite(t);
  read(f,n);
  fib[0]:=0;
  fib[1]:=1;
  for i:=2 to n do fib[i]:=fib[i-1]+fib[i-2];
  writeln(t,fib[n]);
  close(f);
  close(t);
end.
 