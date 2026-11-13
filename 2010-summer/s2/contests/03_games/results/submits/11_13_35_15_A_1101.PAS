program b1;
var f1,f2:text;
    x,i:integer;


BEGIN
 assign(f1, 'knight.in'); reset(f1);
 assign(f2, 'knight.out'); rewrite(f2);
 x:=random(20)+2;
 writeln(f2, 'x');
 close(f1);
 close(f2);
end.