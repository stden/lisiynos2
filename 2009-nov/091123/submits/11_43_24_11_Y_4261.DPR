program y;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var s1,s2:string;
    i,l:integer;

begin
    assign(input,'y.in');
    reset(input);
    read(input,s1);
    close(input);
    for i:=1 to length(s1) do
    s2:=s2+s1[length(s1)-i+1];
    assign(output,'y.out');
    rewrite(output);
    write(output,s2);
    close(output);
end.
