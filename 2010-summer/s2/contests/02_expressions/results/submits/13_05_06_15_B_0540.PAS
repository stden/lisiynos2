program b1;
var f1,f2:text;
    z,x,i:integer;
    s,f:string;

BEGIN
 assign(f1, 'lexem.in'); reset(f1);
 assign(f2, 'lexem.out'); rewrite(f2);
 read(f1,z);
 read(f1,x);
 if z<>x then
  begin
   writeln(f2,'NO');
   close(f1);
   close(f2);
   exit;
  end;
 read(s);
 read(f);
 for i:=1 to z do
  if f[i]<>'*' then
   if f[i]<>s[i] then
    begin
     writeln('NO');
     close(f1);
     close(f2);
     exit;
    end;
 writeln('YES');
 close(f1);
 close(f2);
END.