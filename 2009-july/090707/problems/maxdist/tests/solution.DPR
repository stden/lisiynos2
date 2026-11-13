program maxdist;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
    a:array[1..100,1..100]of integer;
    x:array[1..100]of integer;
    y:array[1..100]of integer;
    n,m,i,j,xc,yc,z:integer;
    c,max:extended;
    q:boolean;
begin
    for i:=1 to 100 do
    for j:=1 to 100 do
    begin
    a[i,j]:=100;
    a[j,i]:=100;
    end;
    assign(input,'maxdist.in');
    reset(input);
    read(input,n);
    for i:=1 to n do
    begin
    read(input,xc,yc);
    x[i]:=xc;
    y[i]:=yc;
    end;
    read(input,m);
    for i:=1 to m do
    begin
    read(input,xc,yc);
    a[xc,yc]:=0;
    a[yc,xc]:=0;
    end;
    for i:=1 to 100 do
    for j:=1 to 100 do
    for z:=1 to 100 do
    begin
    if (a[i,z]+a[z,j])=0 then
    begin
    a[i,j]:=0;
    a[j,i]:=0;
    end;
    end;
    close(input);
    q:=false;
    for i:=1 to n do
    for j:=1 to n do
    begin
    if a[i,j]=100 then q:=true;
    end;
    if q=false then
    begin
    for i:=1 to n do
    for j:=1 to n do
    begin
    c:=sqrt(sqr(x[i]-x[j])+sqr(y[i]-y[j]));
    if max<c then max:=c;
    end;
    assign(output,'maxdist.out');
    rewrite(output);
    write(output,max:7:7);
    end else
    begin
        assign(output,'maxdist.out');
    rewrite(output);
    write(output,'-1');
    end;
    close(output);
end.
