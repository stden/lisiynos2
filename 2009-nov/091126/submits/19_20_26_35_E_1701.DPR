program roman;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var i,j,n,m:integer;
    str:string;
label q;
begin
    assign(input,'roman.in');
    reset(input);
    read(input,n);
    assign(output,'roman.out');
    rewrite(output);
    for i:=1 to n do
    begin
    read(input,m);
    str:='';
    while m>0 do
    begin
    if m>=1000 then
    begin
    m:=m-1000;
    str:=str+'M';
    goto q;
    end;
    if m>=900 then
    begin
    m:=m-900;
    str:=str+'CM';
    goto q;
    end;
    if m>=500 then
    begin
    m:=m-500;
    str:=str+'D';
    goto q;
    end;
    if m>=400 then
    begin
    m:=m-400;
    str:=str+'CD';
    goto q;
    end;
    if m>=100 then
    begin
    m:=m-100;
    str:=str+'C';
    goto q;
    end;
    if m>=90 then
    begin
    m:=m-90;
    str:=str+'XC';
    goto q;
    end;
    if m>=50 then
    begin
    m:=m-50;
    str:=str+'L';
    goto q;
    end;
    if m>=40 then
    begin
    m:=m-40;
    str:=str+'XL';
    goto q;
    end;
    if m>=10 then
    begin
    m:=m-10;
    str:=str+'X';
    goto q;
    end;
    if m>=9 then
    begin
    m:=m-9;
    str:=str+'IX';
    goto q;
    end;
    if m>=5 then
    begin
    m:=m-5;
    str:=str+'V';
    goto q;
    end;
    if m>=4 then
    begin
    m:=m-4;
    str:=str+'IV';
    goto q;
    end;
    if m>0 then
    begin
    m:=m-1;
    str:=str+'I';
    goto q;
    end;
q:
    end;
writeln(output,str);
    end;
    close(input);
    close(output);

end.
