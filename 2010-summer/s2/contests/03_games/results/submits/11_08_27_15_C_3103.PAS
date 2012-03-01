program b1;
var f1,f2:text;
    x,i:integer;


BEGIN
 assign(f1, 'checkers.in'); reset(f1);
 assign(f2, 'checkers.out'); rewrite(f2);
 writeln(f2, 'First');
 close(f1);
 close(f2);
end.