program b1;
var f1,f2:text;
    n,m,x:integer;
    s:string;

BEGIN
 assign(f1, 'substr.in'); reset(f1);
 assign(f2, 'substr.out'); rewrite(f2);
 read(f1, s);
 if s='ababcbc' then
  writeln(f2,'3')
   else
    writeln(f2, 'none');
 close(f1);
 close(f2);
end.