program unreal;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..100]of longint;
    i,j,m,n,min,nm,sum:longint;

begin
    assign(input,'unreal.in');
    reset(input);
    read(input,n);
    min:=99999999;
    for i:=1 to n do
    begin
    sum:=0;
    for j:=1 to n-1 do
    begin
    read(input,m);
    sum:=sum+m;
    end;
    if sum<min then
    begin
    min:=sum;
    nm:=i;
    end;
    end;
    close(input);
    assign(output,'unreal.out');
    rewrite(output);
    write(output,nm);
    close(output);
end.
 