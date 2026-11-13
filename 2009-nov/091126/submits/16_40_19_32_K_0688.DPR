program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var time:array[0..23,0..60,0..60] of integer;
h,m,s,i,n:integer;
begin
  reset(input,'time.in');
  rewrite(output,'time.out');
  read(n);
  for h:=0 to 23 do for m:=0 to 60 do for s:=0 to 60 do time[h,m,s]:=0;
  for i:=1 to n do begin
    read(h,m,s);
    inc(time[h,m,s]);
  end;
  for h:=0 to 23 do for m:=0 to 60 do for s:=0 to 60 do
    for i:=1 to time[h,m,s] do writeln(h,' ',m,' ',s);

end.
 