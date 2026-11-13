program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var c:char;
s:string;
sum,ls:integer;

function count(s:string;l,r:integer):integer;
var TempS:string;
i:integer;
begin
count:=0;
if l<=r then begin
  i:=l;
  TempS:='';
  repeat
  TempS:=TempS+s[i];
  inc(i);
  until (i>r) or (s[i]='*');
  count:=strtoint(TempS)*count(s,i+1,r);
end else count:=1;
end;

begin
  reset(input,'money.in');
  rewrite(output,'money.out');
  while not eoln do
  begin
    c:=' ';
    s:='';
    ls:=0;
    read(c);
    while (c<>'+') and (not eoln) do begin
      inc(ls);
      s:=s+c;
      read(c);
    end;
    if eoln then begin
    s:=s+c;
    inc(ls);
    end;
    sum:=sum+count(s,1,ls);
  end;
  writeln(sum);
end.
