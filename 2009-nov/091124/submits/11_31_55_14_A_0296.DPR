program a;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  n,i:integer;
begin
  reset(input,'simple.in');
  rewrite(output,'siple.out');
  read(n);
  for i:=1 to round(sqrt(n))+1 do begin
    if (n mod i)=0 then begin
      write(1);
      exit;
    end;
  end;
  write(0);
end.
 