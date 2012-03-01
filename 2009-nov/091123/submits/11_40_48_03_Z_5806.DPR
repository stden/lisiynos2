program z;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a,b:longint;

begin
    assign(input,'z.in');
    assign(output,'z.out');
    reset(input);
    rewrite(output);
    read(input,a,b);
    close(input);
    write(output,(a+b));
    close(output);
    end.
