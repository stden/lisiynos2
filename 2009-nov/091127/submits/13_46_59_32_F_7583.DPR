program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[0..5,0..5] of int64;
n,m,i,j:integer;
function asd(x,y,n,m:integer):integer;
var max,i,t:integer;
  begin
  max:=0;
  if (n-x)*(m-y)=1 then max:=a[m,n]
  else
   begin
    for i:=x+1 to n-1 do begin
    t:=sqr(asd(x,y,i,m))+sqr(asd(i,y,n,m));
    if t>max then max:=t;
    end;
    for i:=y+1 to m-1 do begin
    t:=sqr(asd(x,y,n,i))+sqr(asd(x,i,n,m));
    if t>max then max:=t;
    end;
   end;
    
  asd:=max;
  end;
begin
  reset(input,'company.in');
  rewrite(output,'company.out');
  read(n,m);
  for i:=1 to n do for j:=1 to m do read(a[j,i]);
  //writeln(asd(0,0,n,m));

  writeln(asd(0,0,n,m));
end.
