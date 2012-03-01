program airgun;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var h,l,vx,vy,r,x0,x,x2:extended;
    tf:boolean;
begin
    assign(input,'airgun.in');
    reset(input);
    read(input,h,vy,vx,x0,x,r);
    close(input);
    x2:=x+(vx*(2*vy-sqrt(4*vy*vy+8*h*9.8))/(2*9.8));
    if abs(x2-x0)<r then tf:=true else tf:=false;
    assign(output,'airgun.out');
    rewrite(output);
    if tf=true then write(output,'YES') else write(output,'NO');
    close(output);
end.
 