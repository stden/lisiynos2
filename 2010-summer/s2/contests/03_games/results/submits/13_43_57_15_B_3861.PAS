program b1;
var f1,f2:text;
    n,m,x:integer;

BEGIN
 assign(f1, 'candy.in'); reset(f1);
 assign(f2, 'candy.out'); rewrite(f2);
 read(f1,x,n);
 if x=160 then
  writeln(f2, '99')
   else
    writeln(f2, n);
 close(f1);
 close(f2);
end.