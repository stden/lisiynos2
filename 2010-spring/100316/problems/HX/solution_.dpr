{$N+}
Program RailRoad;
const Nmax=16;
Type Tcal=int64;
     TSup=array [1..nmax,1..nmax,1..nmax] of Tcal;
var i,j,p,n,x,y,z:byte;
    s:Tcal;
    Sup:TSup;

function F(x,y,z:byte):Tcal;
var i:byte;
    s:Tcal;
begin
  if Sup[x,y,z]=-1 then
  begin
   s:=0;
   for i:=1 to x-1 do s:=s+F(i,y-1,z-1);
   for i:=x+1 to y do s:=s+F(x,y-1,z);
   sup[x,y,z]:=s;
  end;
  F:=Sup[x,y,z];
end;

begin
  Assign(Input,'h.in'); Reset(Input);
  Assign(Output,'h.out'); Rewrite(Output);
 readln(n,p);
 for x:=1 to n do
  for y:=1 to n do
   for z:=1 to n do
    begin
      Sup[x,y,z]:=-1;
      if (z=1) and (x<>1) then Sup[x,y,z]:=0;
      if (y=z) and (x=y) then Sup[x,y,z]:=1;
    end;
   s:=0;
   for i:=1 to n do
    s:=s+F(i,n,p);
   writeln(s);
end.