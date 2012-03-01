program aYG;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const maxin=32000;
      arr=200000;

label q;

var a:array[1..arr,1..2]of longint;
    i,n,nj,ch:longint;

function exist(x:longint):boolean;
    var j:longint;
        tf:boolean;
    begin
    tf:=false;
    for j:=1 to arr do
    begin
    if (a[j,1]=x) then
    begin
    tf:=true;
    break;
    end;
    end;
    exist:=tf;
    end;
function getpos(xg:integer):integer;
    var j:integer;
    begin
    for j:=1 to arr do
    begin
    if a[j,1]=xg then
    begin
    xg:=j;
    break;
    end;
    end;
    getpos:=xg;
    end;
procedure add(x:integer);
    var fm:integer;
    begin
    if exist(x)=false then
    begin
    fm:=getpos(maxin);
    a[fm,1]:=x;
    a[fm,2]:=1;
    end
    else
    begin
    a[getpos(x),2]:=a[getpos(x),2]+1;
    end;
    end;
begin
    assign(input,'a.in');
    reset(input);
    assign(output,'a.out');
    rewrite(output);
q:  read(input,n);
    if n<>0 then
    begin
    for i:=1 to arr do
    begin
    a[i,1]:=maxin;
    a[i,2]:=0;
    end;
    if n<>0 then
    begin
    for i:=1 to n do
    begin
    read(input,nj);
    add(nj);
    end;
    end;
    for i:=1 to arr do
    begin
    if ((a[i,2])mod 2)=1 then ch:=a[i,1];
    end;
    writeln(output,ch);
    goto q
    end;
    close(input);
    close(output);
end.
