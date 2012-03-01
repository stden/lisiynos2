program light;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..100]of integer;
    i,j,s,e,n,m:integer;

begin
    assign(input,'light.in');
    reset(input);
    read(input,n,m);
    for i:=1 to m do
    begin
    read(input,s,e);
    a[s]:=a[s]+1;
    a[e]:=a[e]+1;
    end;
    close(input);
    assign(output,'light.out');
    rewrite(output);
    for i:=1 to n do
    write(output,a[i],' ');
    close(output);
end.
