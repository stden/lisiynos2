program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var nowd,date:TDateTime;
nday,nmonth,nyear,n,i,j,t:integer;
ts:string;
day,month,diff:array[1..1000000] of integer;
s,dow:array[1..1000000] of string;

begin
  reset(input,'hb.in');
  rewrite(output,'hb.out');
  read(nday,nmonth,nyear);


  nowd:=StrToDate(inttostr(nday)+'.'+inttostr(nmonth)+'.'+inttostr(nyear));

  read(n);
  for i:=1 to n do begin
    read(day[i]);
    read(month[i]);
    read(s[i]);
  end;
  for i:=1 to n do begin
  date:=StrToDate(inttostr(day[i])+'.'+inttostr(month[i])+'.'+inttostr(nyear));
  diff[i]:=round(date-nowd);
  if diff[i]<0 then begin
  if isleapyear(nyear) then diff[i]:=diff[i]+1;

  diff[i]:=diff[i] +365;

  //if isleapyear(nyear) then diff:=diff mod 366 else diff:=diff mod 365;

  end;
  case dayofweek(date) of
  7:dow[i]:='вс';
  1:dow[i]:='пн';
  2:dow[i]:='вт';
  3:dow[i]:='ср';
  4:dow[i]:='чт';
  5:dow[i]:='пт';
  6:dow[i]:='сб';
  end;
//  writeln(diff[i],' ', dayofweek(date),s[i]);
  end;

  for i:=1 to n-1 do
    for j:=i+1 to n do
      if diff[j]<diff[i] then begin
       t:=diff[j];
       diff[j]:=diff[i];
       diff[i]:=t;
       ts:=s[i];
       s[i]:=s[j];
       s[j]:=ts;
       ts:=dow[j];
       dow[j]:=dow[i];
       dow[i]:=ts;
      end;
  for i:=1 to n do
    writeln(diff[i],' ',dow[i],s[i]);
end.
