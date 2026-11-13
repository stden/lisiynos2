program z;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
    i,k:int64;

begin
    assign(input,'z.in');
   reset(input);
   assign(output,'z.out');
   rewrite(output);
    read(i,k);
    i:=i+k;
    write(i);
            close(input);
      close(output);
end.
