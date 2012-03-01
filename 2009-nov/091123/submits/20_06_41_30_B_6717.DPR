program zad_b;
{$APPTYPE CONSOLE}
uses
  SysUtils;

var
  s,dx,dy,i,a,b:integer;
  x,y      :longint;
  fin,fout :text;
  flag:boolean;

begin
  assign(fin,'hopper.in');
  assign(fout,'hopper.out');
  rewrite(fout);
  reset(fin);
  read(fin,s,x,y,dx,dy);
  while s<>0 do
  begin
    i:=0;
    //if not(((((x div s) + (y div s))div 2)=1) and ((x mod s) <>0 ) and((y mod s)<> 0)) then

    if ((dx=s) or(dy=s)) then i:= -1 else
        begin
        a:=x div s;
        b:=y div s;
        if ((a+b) mod 2) =0 then
        begin
        x:=x-(a*s);
        y:=y-(b*s);
        dx:=dx-(dx div s)*s;
        dy:=dy-(dy div s)*s;
        flag:=((x<s)and(y>s)) or ((x>s)and(y<s));
        while not flag do
              begin
              inc(i);
              x:=x+dx;
              y:=y+dy;
              flag:=((x<s)and(y>s)) or ((x>s)and(y<s));
              end;
         end;     
        end;
    writeln(fout,i);
    readln(fin);
    read(fin,s,x,y,dx,dy);
  end;
  close(fin);
  close(fout);
end.

