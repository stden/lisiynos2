program a;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var k,n:int64;
   i,z:integer;
begin
   assign(input,'simple.in');
   reset(input);
   assign(output,'simple.out');
   rewrite(output);
     read(n);
     k:=0;
      z:=trunc(n/2);
     for i:=2 to z do begin
       if (n mod i)=0 then begin
        k:=1; break;
        end; end;
     if k=1 then write(k) else write(0);
close(input);
      close(output);
end.

