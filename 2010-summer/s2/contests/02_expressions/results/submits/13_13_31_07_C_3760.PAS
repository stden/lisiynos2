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
close(f);
assign(f,'lexem.out');
rewrite(f);
w:=1;
while (s[w]<>'.') and (w<=length(s)) do
begin
if isinteger(s[w]) then begin
 s1:=s1+s[w];
  if s[w+1]='.' Then writeln(f,s1);
 end
else begin
     if s1<>'' then writeln(f,s1);
      s1:='';
      writeln(f,s[w]);
      end;
w:=w+1;
end;
close(f);
end.