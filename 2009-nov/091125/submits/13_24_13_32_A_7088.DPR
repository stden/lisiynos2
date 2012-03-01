program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var ans,n,i,b:integer;
begin
  reset(input,'a.in');
  rewrite(output,'a.out');
  read(n);
  while n<>0 do begin
  read(ans);
  for i:=2 to n do begin
  read(b);
  ans:=ans xor b;
  end;
  writeln(ans);
  read(n);
  end;
end.
 