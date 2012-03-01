program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var f,t:text;
i,j,n:integer;
a,b:array[0..50,0..50] of integer;
function max(a,b:int64):int64;
begin
if a>b then max:=a else max:=b;
end;
begin
  assign(f,'d.in');
  assign(t,'d.out');
  reset(f);
  rewrite(t);
  read(f,n);
  for i:=0 to 50 do for j:=0 to 50 do b[i,j]:=0;
  for i:=1 to n do for j:=1 to n do read(f,a[i,j]);
  for i:=1 to n do for j:=1 to n do
    b[i,j]:=max(b[i-1,j],b[i,j-1])+a[i,j];
  writeln(t,b[n,n]);
  close(f);
  close(t);


end.
 