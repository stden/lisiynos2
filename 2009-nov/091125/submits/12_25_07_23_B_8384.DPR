program bYG;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const ml=1000;

var   a:array[1..ml]of byte;
      b:array[1..ml]of byte;
      c:array[1..ml]of byte;
      i,n:integer;
      str:string;

procedure sum();
    begin
    for i:=1 to ml do
    begin
    c[i]:=((a[i]+b[i]));
    end;
    for i:=1 to ml-1 do
    if c[i]>10 then
    begin
    c[i+1]:=c[i+1]+(c[i] div 10);
    c[i]:=c[i] mod 10;
    end;
    end;


procedure transcript();
    begin
    for i:=1 to ml do
    begin
    a[i]:=b[i];
    b[i]:=c[i];
    end;
    end;

function len():integer;
    var l:integer;
    begin
    l:=ml;
    while c[l]=0 do
    l:=l-1;
    len:=l;
    end;

begin
    assign(input,'b.in');
    reset(input);
    read(input,n);
    close(input);
    fillchar(a,sizeof(a),0);
    fillchar(b,sizeof(b),0);
    a[1]:=1;
    b[1]:=1;
    if n>2 then
    begin
    for i:=1 to n-2 do
    begin
    sum;
    transcript;
    end;
    for i:=1 to len do
    str:=concat(chr(c[i]+ord('0')),str);
    end
    else str:='1';
    assign(output,'b.out');
    rewrite(output);
    write(output,str);
    close(output);
end.
