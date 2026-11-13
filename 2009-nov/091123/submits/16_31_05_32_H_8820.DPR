program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var f,t:text;
d:array[0..17,0..17] of int64;
i,j,n,p:integer;
begin
  assign(f,'h.in');
  assign(t,'h.out');
  reset(f);
  rewrite(t);
  read(f,n,p);
  for i:=1 to 16 do d[i,i]:=1;
  for i:=2 to 16 do
    for j:=1 to 16 do
      d[i,j]:=d[i-1,j]*(i-1)+d[i-1,j-1];
  writeln(t,d[n,p]);
  close(f);
  close(t);
end.
 