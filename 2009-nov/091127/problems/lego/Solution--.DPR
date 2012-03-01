program lego;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var s:array[1..1000]of integer;
    f:array[1..1000]of integer;
    n:array[1..1000]of integer;
    i,m,si,l,max:integer;
procedure posLego(b,e:integer);
    var j:integer;
    begin
    for j:=b to e do
    n[j]:=n[j]+1;
    end;
begin
    max:=0;
    assign(input,'lego.in');
    reset(input);
    read(input,m);
    for i:=1 to m do
    begin
    read(input,l,s[i]);
    f[i]:=s[i]+l-1;
    end;
    close(input);
    for i:=1 to m do
    poslego(s[i],f[i]);
    for i:=1 to m do
    if max<n[i] then max:=n[i];
    assign(output,'lego.out');
    rewrite(output);
    write(output,max);
    close(output);
end.
 