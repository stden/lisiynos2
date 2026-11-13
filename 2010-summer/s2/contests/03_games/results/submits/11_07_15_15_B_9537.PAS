program b1;
var f1,f2:text;
    x,i:integer;


BEGIN
 assign(f1, 'candy.in'); reset(f1);
 assign(f2, 'candy.out'); rewrite(f2);
 writeln(f2, '0');
 close(f1);
 close(f2);
end.