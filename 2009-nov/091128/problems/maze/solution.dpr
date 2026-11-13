program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
const MaxN=10;
type TPlace=array[1..5] of integer;

var lab:array[0..maxN+1,0..maxN+1,0..maxN+1,0..maxN+1,0..maxN+1] of integer;
i,d,min,d1,d2,d3,d4,d5:integer;
x:TPlace;
n:array[1..5] of integer;
procedure go(x:TPlace;v:integer);
var k:boolean;
nx:TPlace;
i:integer;
begin
k:=true;
for i:=1 to d do if (x[i]=1) or (x[i]=n[i]) then k:=false;
if k then
  for i:=1 to d do begin
    nx:=x;
    nx[i]:=x[i]+1;
    if lab[nx[1],nx[2],nx[3],nx[4],nx[5]]=1 then begin
    lab[x[1],x[2],x[3],x[4],x[5]]:=0;
    go(nx,v+1);
    lab[x[1],x[2],x[3],x[4],x[5]]:=1;
    end;
    nx[i]:=x[i]-1;
    if lab[nx[1],nx[2],nx[3],nx[4],nx[5]]=1 then begin
    lab[x[1],x[2],x[3],x[4],x[5]]:=0;
    go(nx,v+1);
    lab[x[1],x[2],x[3],x[4],x[5]]:=1;
    end;
  end
  else
    if v<min then min:=v;
end;
begin
  reset(input,'maze.in');
  rewrite(output,'maze.out');
  readln(d);
  for i:=1 to 5 do n[i]:=1;
  for i:=1 to 5 do x[i]:=1;
  for d5:=0 to 11 do
    for d4:=0 to 11 do
      for d3:=0 to 11 do
        for d2:=0 to 11 do
          for d1:=0 to 11 do
            lab[d1,d2,d3,d4,d5]:=0;

  
  for i:=1 to d do read(x[i]);
  readln;
  for i:=1 to d do read(n[i]);
  readln;
  for d5:=1 to n[5] do
    for d4:=1 to n[4] do
      for d3:=1 to n[3] do
        for d2:=1 to n[2] do
          for d1:=1 to n[1] do
            read(lab[d1,d2,d3,d4,d5]);
  min:=1000000;
  go(x,0);
  writeln(min);
end.
 