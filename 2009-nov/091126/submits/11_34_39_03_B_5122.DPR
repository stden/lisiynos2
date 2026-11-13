program coloring;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const size=25;

var p:array[1..size,1..size]of int64;
    n,a,b,c,m,s:int64;
    i,j:integer;

function Co(n,k:integer):int64;
    begin
    co:=p[n+2,k+2];
    end;


begin
    for i:=1 to size do
    begin
    p[i,i]:=1;
    p[1,i]:=1;
    end;
    for i:=3 to size do
    for j:=2 to i-1 do
    begin
    p[i,j]:=p[i-1,j]+p[i-1,j-1];
    end;
    assign(input,'coloring.in');
    reset(input);
    read(input,a,b,c);
    close(input);
    s:=a+b+c;
    m:=co(s,a);
    s:=b+c;
    m:=m*co(s,b);
    s:=c;
    m:=m*co(s,c);
    assign(output,'coloring.out');
    rewrite(output);
    write(output,m);
    close(output);
end.
