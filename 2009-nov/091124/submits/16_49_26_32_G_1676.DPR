program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
function count(s:string;l,r:integer):boolean;
var b:boolean;
begin
if s[l]='&' then count:=count(s,l+1,r) else
if s[l]='T' then b:=true else b:=false;
if l=r then count:=b else
  count:=b and count(s,l+1,r);
end;
var s:string;
c:char;
ls:integer;
ans:boolean;

begin
  reset(input,'holiday.in');
  rewrite(output,'holiday.out');
  ans:=false;
  while not eof do begin
    c:=' ';
    s:='';
    ls:=0;
    read(c);
    while (c<>'|') and (not eoln) do begin
      s:=s+c;
      inc(ls);
      read(c);
    end;
    if eoln then begin
      s:=s+c;
      inc(ls);
    end;
    ans:=ans or count(s,1,ls);
  end;
  if ans then writeln('YES') else writeln('NO');
end.
