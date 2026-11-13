program simple;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var n:longint;
    i:integer;
    k:integer;
    tf:boolean;
begin
    assign(input,'simple.in');
    reset(input);
    read(input,n);
    close(input);
    tf:=false;
    k:=round(sqrt(n))+1;
    for i:=2 to k do
    begin
    if (n mod i)=0 then tf:=true;
    end;
    assign(output,'simple.out');
    rewrite(output);
    if tf=true then
    write(output,'1')
    else
    write(output,'0');
    close(output);
end.
 