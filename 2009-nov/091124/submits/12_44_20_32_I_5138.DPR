program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var i,n,socks,helm,gun,brush,knife,fa,port:integer;
s:string;
begin

  reset(input,'stuffbag.in');
  rewrite(output,'stuffbag.out');
  readln(n);
    socks:=0;
    helm:=0;
    gun:=0;
    brush:=0;
    knife:=0;
    fa:=0;
    port:=0;
  for i:=1 to n do begin
    readln(s);

    if s='NOSKI' then inc(socks);
    if s='SHLEM' then inc(helm);
    if s='AVTOMAT' then inc(gun);
    if s='SCHETKA' then inc(brush);
    if s='NOGH' then inc(knife);
    if s='APTECHKA' then inc(fa);
    if s='PORTIANKI' then inc(port);
    end;
    for i:=1 to gun do writeln('AVTOMAT');
    for i:=1 to fa do writeln('APTECHKA');
    for i:=1 to knife do writeln('NOGH');
    for i:=1 to socks do writeln('NOSKI');
    for i:=1 to port do writeln('PORTIANKI');
    for i:=1 to brush do writeln('SCHETKA');
    for i:=1 to helm do writeln('SHLEM');
end.
