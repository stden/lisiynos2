program a;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  n,i:integer;
begin
  reset(input,'simple.in');
  rewrite(output,'simple.out');
  read(n);
  for i:=2 to round(sqrt(n))+1 do begin
    if (n mod i)=0 then begin
      writeln(1);
      exit;
    end;
  end;
  writeln(0);
end.
 