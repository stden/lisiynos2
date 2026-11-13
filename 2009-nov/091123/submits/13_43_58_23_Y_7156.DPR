program y;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var s,c:string;
    i,l:integer;

begin
    assign(input,'y.in');
    reset(input);
    read(input,s);
    close(input);
    for i:=1 to length(s) do
    s:=c+s[length(s)-i+1];
    assign(output,'y.out');
    rewrite(output);
    write(output,c);
    close(output);
end.
