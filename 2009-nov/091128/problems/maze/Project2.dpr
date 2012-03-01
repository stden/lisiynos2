{ћногомерный лабиринт}

program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type TPlace=array[1..5] of integer;
const MaxN=10;
problemname='maze';


var x:TPlace;
d,min,d1,d2,d3,d4,d5,i:integer;
n:array[1..5] of integer;
lab:array[0..MaxN+1,0..MaxN+1,0..MaxN+1,0..MaxN+1,0..MaxN+1] of byte;



procedure go(x:TPlace;v:integer);
var nx:TPlace;
k:boolean;
i:integer;
begin
k:=true;
for i:=1 to d do if (x[i]=1) or (x[i]=n[i]) then k:=false;
if k then
  for i:=1 to d do begin
    lab[x[1],x[2],x[3],x[4],x[5]]:=0;
    nx:=x;
    nx[i]:=x[i]+1;
    if lab[nx[1],nx[2],nx[3],nx[4],nx[5]]<>0 then
      begin
        go(nx,v+1);
      end;
    nx[i]:=x[i]-1;
    if lab[nx[1],nx[2],nx[3],nx[4],nx[5]]<>0 then
      begin
        go(nx,v+1);
      end;

  end else
  if v<min then min:=v;
end;

begin
for d1:=0 to MaxN+1 do
 for d2:=0 to MaxN+1 do
  for d3:=0 to MaxN+1 do
   for d4:=0 to MaxN+1 do
    for d5:=0 to MaxN+1 do
      lab[d1,d2,d3,d4,d5]:=0;
  {K-мерный лабиринт}
  {Ќайти кратчайший путь в k-мерном лабиринте.}
  reset(input,problemname+'.in');
  rewrite(output,problemname+'.out');
  read(d);

  {„итаем границы лабиринта в каждом измерении}
  for i:=1 to 5 do n[i] :=1;
  for i:=1 to d do read(n[i]);
  {n[i] - граница лабиринта в n-ном измерении}
    {читаем нач положение}
  for i:=1 to 5 do x[i]:=1;
  for i:=1 to d do read(x[i]);

  {читаем лабиринт}
  for d5:=1 to n[5] do
    for d4:=1 to n[4] do
      for d3:=1 to n[3] do
        for d2:=1 to n[2] do
          for d1:=1 to n[1] do
            read(lab[d1,d2,d3,d4,d5]);

  min:=100000;
  go(x,0);
  writeln(min);


end.
