program zad_b;
{$APPTYPE CONSOLE}
uses
  SysUtils;

var
  s,dx,dy,i:integer;
  x,y      :longint;
  fin,fout :text;
function on_white(var s1:integer;var x1,y1:longint):boolean;
begin
  on_white:=Odd(((x div s)+(y div s)))and(((x mod s)<>0)and((y mod s)<>0));
end;

begin
  assign(fin,'hopper.in');
  assign(fout,'hopper.out');
  rewrite(fout);
  reset(fin);
  read(fin,s,x,y,dx,dy);
  while s<>0 do
  begin
    i:=0;
    if ((dx=s) or(dy=s)) then i:= -1 else
        while not on_white(s,x,y) do
              begin
              inc(i);
              x:=x+dx;
              y:=y+dy;
              end;
    writeln(fout,i);
    readln(fin);
    read(fin,s,x,y,dx,dy);
  end;
  close(fin);
  close(fout);
end.

