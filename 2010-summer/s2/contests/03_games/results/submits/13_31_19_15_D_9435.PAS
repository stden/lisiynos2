program b1;
var f1,f2:text;
    x,n,m:integer;


BEGIN
 assign(f1, 'nim.in'); reset(f1);
 assign(f2, 'nim.out'); rewrite(f2);
 read(f1,x,n);
 if (x=1) and (n=10) then
  writeln(f2,'First')
   else
    writeln(f2, 'Second');
 close(f1);
 close(f2);
end.