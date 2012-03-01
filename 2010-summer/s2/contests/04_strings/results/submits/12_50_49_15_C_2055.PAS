program c;
var f1,f2:text;
    i,k:integer;
    s,t:string;

begin
 assign(f1, 'palin.in'); reset(f1);
 assign(f2, 'palin.out'); rewrite(f2);
 read(f1,s);
 k:=length(s);
 for i:=1 to k do
  if s[i]<>' ' then
    t:=t+s[i];
 for i:=1 to length(t) do
  if t[i]<>t[length(t)-i+1] then
   begin
    writeln(f2, 'NO');
    exit;
   end;
 writeln(f2, 'YES');
 close(f1);
 close(f2);
end.
 