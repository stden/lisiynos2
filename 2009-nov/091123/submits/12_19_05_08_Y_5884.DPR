program a;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
    s:string;
    i,k:integer;

begin
    assign(input,'y.in');
   reset(input);
   assign(output,'y.out');
   rewrite(output);
    read(s);
    k:=length(s);

    for i:=k downto 1 do
      write(s[i]);
            close(input);
      close(output);
end.
