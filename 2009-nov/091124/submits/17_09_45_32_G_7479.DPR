program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
type exp=array[0..1001] of char;
{function count(s:exp;l,r:integer):boolean;
var b:boolean;
begin
if s[l]='&' then count:=count(s,l+1,r) else
if s[l]='T' then b:=true else b:=false;
if l=r then count:=b else
  count:=b and count(s,l+1,r);
end;   }
var s:exp;
c:char;
ls,l:integer;
ans,count,b:boolean;
begin
  reset(input,'holiday.in');
  rewrite(output,'holiday.out');
  ans:=false;
  while not eoln do begin
    c:=' ';
    s:='';
    ls:=0;
    read(c);
    while (c<>'|') and (not eoln) do begin
      inc(ls);
      s[ls]:=c;
      read(c);
    end;
    if eoln then begin
      inc(ls);
      s[ls]:=c;
    end;
    l:=1;
    count:=true;
while l<=ls do begin


if s[l]<>'&' then begin
   if s[l]='T' then b:=true else b:=false;
   count:=count and b;
end;
inc(l);
end;
    ans:=ans or count;
  end;
  if ans then writeln('YES') else writeln('NO');
end.
