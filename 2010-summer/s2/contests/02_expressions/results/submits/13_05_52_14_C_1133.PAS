program qq;
var s,s1,q:string;
    f:text;
    w:integer;
    b:boolean;
function isInteger( c:string ):boolean;
var Value,ErrCode:Integer;
begin
  Val(c,Value,ErrCode);
  isInteger := ErrCode = 0;
end;
begin
assign(f,'lexem.in');
reset(f);
readln(f,s);
w:=1;
while (s[w]<>'.') and (w<=length(s)) do
begin
if isinteger(s[w]) then s1:=s1+s[w]
else begin
     writeln(s1);
      s1:='';
      writeln(s[w]);
      end;
w:=w+1;
end;
end.