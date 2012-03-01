program left;

{$APPTYPE CONSOLE}

uses
  SysUtils,math;

var x:array[1..666]of integer;
    y:array[1..666]of integer;
    i,j,n,x1,y1,x2,y2,x3,y3:integer;
    sum:longint;
    an,bn:extended;
begin
    assign(input,'left.in');
    reset(input);
    read(input,n);
    for i:=1 to n do
    begin
    read(input,x[i],y[i]);
    end;
    close(input);
    for i:=1 to n-2 do
    begin
    x1:=x[i];
    x2:=x[i+1];
    y1:=y[i];
    y2:=y[i+1];
    x3:=x[i+2];
    y3:=y[i+2];
    an:=arctan(((x2-x1)/(y2-y1)));
    bn:=arctan(((x3-x2)/(y3-y2)));
    if an>bn then sum:=sum+666;
    end;
    assign(output,'left.out');
    rewrite(output);
    write(output,sum,'$');
    close(output);
end.
 