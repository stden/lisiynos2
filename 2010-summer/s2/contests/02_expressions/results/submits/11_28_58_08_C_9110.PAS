program C;
var s:string;i:integer;
begin
assign(input,'lexem.in');
assign(output,'lexem.out');
reset(input);
read(s);
rewrite(output);
for i:=1 to (length(s)) do
 begin
 if s[i]<>'.' then
  if (ord(s[i])<=ord('9')) and (ord(s[i+1])<=ord('9')) and (ord(s[i])>=ord('0')) and (ord(s[i+1])>=ord('0')) then
  write(s[i]) else writeln(s[i]);
  end;
close(input);
close(output);
end.