program sun;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var v1,v2,a1,a2,x:extended;

begin
    assign(input,'sun.in');
    reset(input);
    read(input,v1,v2,a1,a2);
    close(input);
    x:=abs((a2-a1)/(v2-v1));
    assign(output,'sun.out');
    rewrite(output);
    write(output,x:3:2);
    close(output);
end.
 