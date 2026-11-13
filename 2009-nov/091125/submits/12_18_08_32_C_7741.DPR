program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var i,del,k:integer;
r:boolean;
begin
  reset(input,'c.in');
  rewrite(output,'c.out');
  read(k);
  i:=2;
  while (i<=round(sqrt(k))) and (not r) do begin

    if k mod i =0 then begin
  r:=true;
  del:=i;
  end;
  inc(i);
  end;
  if r then writeln('NO,',del) else writeln('YES');
end.
 