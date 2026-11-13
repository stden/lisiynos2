{--$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+}
{--$M 16384,0,655360}
uses testlib, SysUtils;

const max=20;

type mas=array[1..max] of integer;

var st:string;
    a,b,sign:mas;
    kolnum,userkolnum,t:integer;
    result:longint;
    answer:string;

procedure error(code:integer);
 begin
  quit(_wa,'');
 end;

procedure correct;
 begin
  quit(_ok,'');
 end;

procedure delspace(var s:string);
 begin
  while (length(s)>0) and (s[1]=' ') do delete(s,1,1);
  while (length(s)>0) and (s[length(s)]=' ') do delete(s,length(s),1);
 end;

function getnum(var st:string):longint;
var i:integer;
    num:integer;
 begin
  i:=1;
  while (i<=length(st)) and (st[i] in ['0'..'9']) do inc(i);
  getnum:=StrToInt(copy(st,1,i-1));
  delete(st,1,i-1);
  delspace(st);
 end;

function getsign(var st:string):integer;
 begin
  case st[1] of
  '*' : getsign:=1;
  '+' : getsign:=2;
  '-' : getsign:=3;
  else
  error(1);
  end;
 delete(st,1,1);
 delspace(st);
 end;

procedure makestring;
var i:integer;
 begin
  i:=0;
  while length(st)>0 do
   begin
    if i>=kolnum then error(1);
    inc(i);
    a[i]:=getnum(st);
    if (length(st)=0) and (i<kolnum) then error(1);
    if length(st)>0 then sign[i]:=getsign(st);
   end;
  if length(st)>0 then error(1);
  userkolnum:=i;
 end;

function makemul(var i:integer):comp;
var q:comp;
begin
 q:=a[i];
 while (sign[i]=1) and (i<=kolnum-1) do
  begin
   inc(i);
   q:=q*a[i];
  end;
 makemul:=q;
 inc(i);
end;

function makesum:comp;
var i:integer;
    k:longint;
    sum:comp;
 begin
  i:=1;
  sum:=makemul(i);
  while i<=kolnum do
   begin
    if sign[i-1]=2 then k:=1 else k:=-1;
    sum:=sum+k*makemul(i);
   end;
  makesum:=sum;
 end;

procedure checkout;
var i:integer;
 begin
  makestring;
  if userkolnum<>kolnum then error(1);
  for i:=1 to kolnum do
   if a[i]<>b[i] then error(1);
  if makesum<>result then error(1);
 end;

begin
 answer:=ans.readstring;
 st:=ouf.readstring;
 delspace(answer);
 delspace(st);
 if answer='No' then
  if st='0' then correct else error(1);
 result:=inf.readlongint;
 kolnum:=inf.readinteger;
 for t:=1 to kolnum do b[t]:=inf.readinteger;
 checkout;
 correct;
end.