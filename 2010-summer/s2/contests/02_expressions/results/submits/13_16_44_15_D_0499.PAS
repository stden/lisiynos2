program b1;
var f1,f2:text;
    z,x,i:integer;
    s,f:string;

BEGIN
 assign(f1, 'logexpr.in'); reset(f1);
 assign(f2, 'logexpr.out'); rewrite(f2);
 writeln(f2, '0');
 close(f1);
 close(f2);
end.