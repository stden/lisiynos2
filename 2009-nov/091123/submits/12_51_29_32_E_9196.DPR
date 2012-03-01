program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var f,t:text;
i,j,x,y,k,u:integer;
d,d1:array[-17..17,-17..17] of int64;

begin
  assign(f,'e.in');
  assign(t,'e.out');
  reset(f);
  rewrite(t);
  read(f,k);
  read(f,x);
  read(f,y);
  for i:=-17 to 17 do for j:=-17 to 17 do begin
  d[i,j]:=0;
  d1[i,j]:=0;
  end;
  d[0,0]:=1;
  d1[0,0]:=1;
  for u:=1 to k do begin
    for i:=-16 to 16 do for j:=-16 to 16 do
      d1[i,j]:=d[i-1,j]+d[i+1,j]+d[i,j-1]+d[i,j+1];
    for i:=-16 to 16 do for j:=-16 to 16 do
      d[i,j]:=d1[i,j];
  end;
  writeln(t,d[x,y]);
  close(f);
  close(t);
end.
