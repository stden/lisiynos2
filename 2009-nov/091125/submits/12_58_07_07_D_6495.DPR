program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  n,i,j:integer;
  s:string;

begin
  reset(input,'d.in');
  rewrite(output,'d.out');
  read(n);
  s:='';
  for i:= 1 to n do
    for j:= 1 to i do begin
      s:=s+IntToStr(j);
      if length(s)>=n then
        break;
    end;
  writeln(s[n]);
end.
