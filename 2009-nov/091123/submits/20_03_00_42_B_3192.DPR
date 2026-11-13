program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var f1,f3:text;
    s,x,y,dx,dy,n,i,j,xx,yy:longint;
    flag:boolean;
begin

  { TODO -oUser -cConsole Main : Insert code here }
  assign(f1,'hopper.in');
  reset(f1);
  assign(f3,'hopper.out');
  rewrite(f3);
  //writeln(f3,'sfsfss');
  repeat
   begin
    read(f1,s);
    read(f1,x);
    read(f1,y);
    read(f1,dx);
    read(f1,dy);
    if (s=0) and (x=0) and (y=0) and (dx=0) and (dy=0) then break;
    flag:=true;
    i:=0;
    x:=x-dx;
    y:=y-dy;
    while flag and (i<=10000) do
    begin
     x:=x+dx;
     y:=y+dy;
     xx:=x div s;
     yy:=y div s;
     if yy mod 2=0 then
      begin
       if xx mod 2<>0 then  begin
        if (x>(xx*s)) and (x<(xx*s +s)) and
           (y>(yy*s)) and (y<(yy*s +s)) and ((xx<>0) or (yy<>0)) then
                                                       begin
                                                       writeln(f3,i);
                                                       flag:=false;
                                                       end;
       end;
      end
     else
      begin
      if xx mod 2=0 then  begin
        if (x>(xx*s)) and (x<(xx*s +s)) and
           (y>(yy*s)) and (y<(yy*s +s)) and ((xx<>0) or (yy<>0)) then
                                                       begin
                                                       flag:=false;
                                                       writeln(f3,i);
                                                       end;
        end;
      end;
     i:=i+1;
    end;
    if flag then writeln(f3,'-1');
   end;
 until (s=0) and (x=0) and (y=0) and (dx=0) and (dy=0);
 close(f1);
 close(f3);
end.
