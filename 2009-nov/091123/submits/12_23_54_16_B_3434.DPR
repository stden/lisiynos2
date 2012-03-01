program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
  n,i:integer;
  fib:array [1..10000] of int64;

begin
  reset(input, 'b.in');
  rewrite(output, 'b.out');
  read(n);
  fib[1]:=1;
  fib[2]:=1;
  for i := 3 to n do
  begin
    fib[i]:=fib[i-1]+fib[i-2];
  end;
  write(fib[n]);
end.
