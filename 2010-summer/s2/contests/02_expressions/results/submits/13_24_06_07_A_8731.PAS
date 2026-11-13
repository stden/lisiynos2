program qqq;
uses crt;
var z,pos,w,e,t:longint;
     b:boolean;
    s:string;
    f:text;
function isInteger( s:string ):boolean;
var Value,ErrCode:Integer;
begin
  Val(s,Value,ErrCode);
  isInteger := ErrCode = 0;
end;
function tern : longint; forward;
function sum : longint; forward;
function mult : longint; forward;
function tern : longint;
var r:longint;

begin
 if s[pos]='(' then
     begin
     pos:=pos+1;
     r:=sum;
     if s[pos] <>')' then
     begin
     write(f,'WRONG');
     b:=true;
     tern:=0;
     end;
     pos:=pos+1;
     tern:=r;
     exit;
     end;
     r:=0;
     while isinteger(s[pos]) and (pos<=w)  do
     begin
     r:=r*10+ord(s[pos])-ord('0');
     pos:=pos+1;
     end;
     if pos<=length(s) then
     if s[pos]='.' then begin
      tern:= r;
      pos:=w+1;
      exit;
     end;
     if (s[pos]<>'(') and (s[pos]<>')') and (s[pos]<>'-') and (s[pos]<>'+') and (s[pos]<>'*') then begin
     write(f,'WRONG');
     b:=true;
     tern:=0;
     end;
     tern:=r;
end;
function mult : longint;
var r:longint;
begin
r:=0;
 r:=tern;
 while (pos<w) and (s[pos]='*') do begin
 pos:=pos+1;
 r:=r*tern;
 end;
 mult:=r;
end;
function sum : longint;
var r:longint;
begin
r:=0;
 r:=mult;
  while (pos<w) and ((s[pos]='+') or (s[pos]='-'))do
 begin
 pos:=pos+1;
 if s[pos-1]='+' then
 begin
 r:=r+mult;
 end;
 if s[pos-1]='-' then
 r:=r-mult;
 end;
 sum:=r;
end;
 begin
pos:=1;
assign(f,'expr.in');
reset(f);
readln(f,s);
close(f);
assign(f,'expr.out');
rewrite(f);
w:=length(s);
e:=sum;
if not b then
write(f,e);
close(f);
end.
