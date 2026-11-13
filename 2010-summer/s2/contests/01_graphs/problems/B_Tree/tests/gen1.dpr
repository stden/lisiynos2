program gen1;

{$APPTYPE CONSOLE}

uses
 SysUtils,Math;

var G:array [0..200,0..200] of integer;
    prev:array [0..200] of integer;
    n,m,i,j,x,y:integer;
    name:string;

function Get(v:integer):integer;
begin
 if prev[v]<>v then prev[v]:=Get(prev[v]);
 result:=prev[v]
end;

procedure Union(x,y:integer);
begin
 prev[x]:=y
end;

begin
 n:=strtoint(paramstr(1));
 m:=strtoint(paramstr(2));
 name:=paramstr(3);
 rewrite(output,name);
 for i:=1 to n do prev[i]:=i;
 fillchar(G,sizeof(G),0);
 randseed:=666;
 writeln(n);
 if m=0 then begin
   for i:=1 to n - 1 do begin
    repeat
     x:=random(n)+1;
     y:=random(n)+1;
    until x<>y;
     if Get(x)<>Get(y) then begin
       G[x,y]:=1;
       G[y,x]:=1;
       Union(Get(x),Get(y))
      end
    end
  end
 else 
  for i:=1 to min(10*n,n*(n-1) shr 1) do begin
    repeat 
      x:=random(n)+1;
      y:=random(n)+1;
    until x<>y;
    G[x,y]:=1;
    G[y,x]:=1
   end;
 for i:=1 to n do begin
   for j:=1 to n do write(g[i,j],' ');
   writeln
  end
end.
