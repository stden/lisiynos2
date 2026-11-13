program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var i,j,n,xi,li,max:integer;
a:array[0..1000] of integer;

function findmax(b,e:integer):integer;
var max,i:integer;
begin
max:=0;
for i:=b to e do if a[i]>max then max:=a[i];
findmax:=max;
end;

begin
for i:=0 to n do a[i]:=0;
  reset(input,'lego.in');
  rewrite(output,'lego.out');
  read(n);
  for i:=1 to n do begin
   read(li,xi);
   max:=findmax(xi+1,xi+li);
   for j:=xi+1 to xi+li do a[j]:=max+1;
  end;
  max:=findmax(0,n);
  writeln(max);
end.
