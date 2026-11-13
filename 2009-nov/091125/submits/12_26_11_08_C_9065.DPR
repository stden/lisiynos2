program a;

{$APPTYPE CONSOLE}

uses
  SysUtils;
const
  y='YES';
  l='NO,';
var n:int64;
   i,z,x:integer;
begin
   assign(input,'c.in');
   reset(input);
   assign(output,'c.out');
   rewrite(output);
     read(n);
      z:=trunc(n/2);
     for i:=2 to  z do begin
      if (n mod i)=0 then begin
      write(l,i);x:=1;break;   end;
       end;
      if x<>1 then write(y);
close(input);
close(output);
end.

