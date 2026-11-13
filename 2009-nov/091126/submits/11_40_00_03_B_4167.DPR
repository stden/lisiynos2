program color;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..100,1..100]of integer;
    b:array[1..100]of integer;
    i,j,m,n:integer;
begin
    assign(input,'color.in');
    reset(input);
    read(input,n);
    for i:=1 to n do
    for j:=1 to n do
    begin
    read(input,a[i,j]);
    a[j,i]:=a[i,j];
    end;
    for i:=1 to n do
    read(input,b[i]);
    close(input);
    for i:=1 to n do
    for j:=1 to n do
    begin
    if (a[i,j]=1) and (b[i]<>b[j]) then m:=m+1;
    end;
    m:=m div 2;
    assign(output,'color.out');
    rewrite(output);
    write(output,m);
    close(output);
end.

