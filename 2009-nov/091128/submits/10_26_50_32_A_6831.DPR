program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var x1,x2,x3,y1,y2,y3,n,k,i:integer;
function turnleft(x1,y1,x2,y2,x3,y3:integer):boolean;
var a:integer;
begin

   a:=(x2-x1)*(y3-y1)-(x3-x1)*(y2-y1);
   if a>0 then turnleft:=True else turnleft:=False;


end;
begin
  reset(input,'left.in');
  rewrite(output,'left.out');
  read(n);
  read(x1,y1);
  read(x2,y2);
  k:=0;
  for i:=3 to n do begin
    read(x3,y3);
    if turnleft(x1,y1,x2,y2,x3,y3) then inc(k);
    x1:=x2;x2:=x3;
    y1:=y2;y2:=y3;
  end;
  writeln(k*666,'$');

end.
