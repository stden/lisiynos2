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

  writeln(d[0,1]:0:2);



end.
