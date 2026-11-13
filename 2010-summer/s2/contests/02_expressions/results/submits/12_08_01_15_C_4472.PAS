program c1;
var f1,f2:text;
    x,pos,i:integer;
    s:string;
    z:char;

BEGIN
 pos:=1;
 assign(f1, 'lexem.in'); reset(f1);
 assign(f2, 'lexem.out'); rewrite(f2);
 read(f1,s);
 for i:=1 to length(s) do
  if s[i]='.' then
   begin
    x:=i-1;
    break;
   end;
 for i:=1 to x do
  begin
   z:=s[i];
   writeln(f2,z);
 end;
 close(f1);
 close(f2);
END.