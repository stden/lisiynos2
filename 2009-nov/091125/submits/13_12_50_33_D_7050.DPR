program ZADD;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var s: string;
  i,j,n:longint;

begin
 reset(input,'d.in');
 rewrite(output,'d.out');
  read(n);  s:='';
  for i:=1 to n do
    for j:=1 to i do begin
      s:=s+inttostr(j);
      if length(s)>=n then break;
    end;


  write(s[n]);


end.
