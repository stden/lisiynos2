program b1;
var f1,f2:text;
    x,n,m:integer;


BEGIN
 assign(f1, 'candy.in'); reset(f1);
 assign(f2, 'candy.out'); rewrite(f2);
 read(f1,x,n);
 if (x mod 2)=1 then
  writeln(f2, n )
   else
    writeln(f2,'0');
 close(f1);
 close(f2);
end.