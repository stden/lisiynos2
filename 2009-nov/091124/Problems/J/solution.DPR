program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const inf=1000000000000000;

var i,j,k:integer;
n,m,a,a1:integer;
x,y:array[0..10] of real;
field,forest:real;
d:array[0..10,0..10] of real;
s:string;


begin
  reset(input,'flame.in');
  rewrite(output,'flame.out');
  read(forest,field,n,m);

  for i:=0 to n do for j:=0 to n do d[i,j]:=inf;

  for i:=0 to n-1 do read(x[i],y[i]);
  for i:=1 to m do begin
  read(a,a1);
  readln(s);
  if pos('FOREST',s)<>0 then begin
        d[a,a1]:=sqrt((sqr(x[a]-x[a1])+sqr(y[a]-y[a1])))/forest;
        d[a1,a]:=d[a,a1];
  end;
  if pos('FIELD',s)<>0 then begin
       d[a,a1]:=sqrt((sqr(x[a]-x[a1])+sqr(y[a]-y[a1])))/field;
       d[a1,a]:=d[a,a1];
  end;
  end;
  

  for k:=0 to n-1 do
    for i:=0 to n-1 do
      for j:=0 to n-1 do
        if d[i,j]>d[i,k]+d[k,j] then begin
        d[i,j]:=d[i,k]+d[k,j];
        d[j,i]:=d[i,j];
        end;

    for i := 0 to n-1 do begin
      for j := 0 to n-1 do 
        write(d[i,j]:15:2);
      writeln;
    end;

  writeln(d[0,1]:0:2);

{
0.41 84.67 8 7
-2.126957 8.009308
3.962401 -1.708548
2.604816 3.840052
3.943449 -3.891903
1.534959 2.501419
-4.015412 -1.005127
-1.547960 -4.597064
-3.101382 -3.687155
1 2 FOREST
2 3 FIELD
3 4 FIELD
4 5 FOREST
5 6 FOREST
6 7 FOREST
7 0 FIELD
}

end.
