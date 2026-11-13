program qqq;
uses crt;
var z,pos,w,t:longint;
     b,e:boolean;
    s:string;
    f:text;
function isInteger( s:string ):boolean;
var Value,ErrCode:Integer;
begin
  Val(s,Value,ErrCode);
  isInteger := ErrCode = 0;
end;
function inttobool (h:integer) :boolean;
begin
if h=0 then inttobool:=false
else inttobool:=true;
end;
function tern : boolean; forward;
function sum : boolean; forward;
function mult : boolean; forward;

function tern : boolean;
var r:boolean;

begin
 if s[pos]='!' then
   r:=not tern;
 if s[pos]='(' then
     begin
     pos:=pos+1;
     r:=sum;
     if s[pos] <>')' then
     begin
     write(f,'WRONG');
     b:=true;
     tern:=false;
     end;
     pos:=pos+1;
     tern:=r;
     exit;
     end;
     r:=false;
     if isinteger(s[pos]) and (pos<=w) then
     begin
    if s[pos]='0' then r:=false
    else r:=true;

     pos:=pos+1;
     end;
     if pos<=length(s) then
     if s[pos]='.' then begin
      tern:= r;
      pos:=w+1;
      exit;
     end;
     if (s[pos]<>'(') and (s[pos]<>')') and (s[pos]<>'|') and (s[pos]<>'^') and (s[pos]<>'!') and(s[pos]<>'&') then begin
     write(f,'WRONG');
     b:=true;
     tern:=false;
     end;
     tern:=r;
end;
function mult : boolean;
var r:boolean;
begin
r:=false;
 r:=tern;
 while (pos<w) and (s[pos]='&') do begin
 pos:=pos+1;
 r:=r and tern;
 end;
 mult:=r;
end;

function sum : boolean;
var r:boolean;
begin
r:=false;
 r:=mult;
  while (pos<w) and ((s[pos]='|') or (s[pos]='^'))do
 begin
 pos:=pos+1;
 if s[pos-1]='|' then
 begin
 r:=r or mult;
 end;
 if s[pos-1]='^' then
 r:=r xor mult;
 end;
 sum:=r;
end;
 begin
pos:=1;
assign(f,'logexpr.in');
reset(f);
readln(f,s);
close(f);
assign(f,'logexpr.out');
rewrite(f);
w:=length(s);
e:=sum;
if not b then
 begin
 if e=false then
  write(f,0)
  else write(f,1);
 end;
close(f);
end.
