program circles;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var ax,bx,ay,by,x1,x2,y1,y2,a,b,c,d,r1,r2,dc,x0,y0,mult:extended;
    i,n:integer;
label q;
begin
    assign(input,'circles.in');
    assign(output,'circles.out');
    reset(input);
    rewrite(output);
    read(input,n);
    for i:=1 to n do
    begin
    read(input,x1,y1,r1);
    read(input,x2,y2,r2);
    a:=0-(2*x2);
    b:=0-(2*y2);
    c:=sqr(x2)+sqr(y2)+sqr(r1)-sqr(r2);
    dc:=sqrt(sqr(x1-x2)+sqr(y1-y2));
    if (dc>(r1+r2)) or (dc<abs(r1-r2)) then
    begin
    writeln(output,'There are no points!!!');
    writeln(output);
    goto q;
    end;
    if (x1=x2) and (y1=y2) and (r1=r2) then
    begin
    writeln(output,'I can"t count them - too many points :(');
    writeln(output);
    goto q;
    end;
    x0:=0-(a*c/(sqr(a)+sqr(b)));
    y0:=0-(b*c/(sqr(a)+sqr(b)));
    d:=sqrt(sqr(r1)-(sqr(c)/(sqr(a)+sqr(b))));
    mult:=sqrt(sqr(d)/(sqr(a)+sqr(b)));
    ax:=x0+(b*mult);
    ay:=y0+(b*mult);
    bx:=x0+(b*mult);
    by:=y0+(a*mult);
    if (ax=bx) and (ay=by) then
    begin
    writeln(output,'There are only 1 of them....');
    writeln(output,ax:12:12,' ',ay:12:12);
    writeln(output);
    end
    else
    begin
    writeln(output,'There are only 2 of them....');
    writeln(output,ax:12:12,' ',ay:12:12);
    writeln(output,bx:12:12,' ',by:12:12);
    writeln(output);
    end;
    q:
    end;
    close(output);
end.
