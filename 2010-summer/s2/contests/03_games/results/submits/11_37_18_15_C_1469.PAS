program b1;
var f1,f2:text;
    x,n,m:integer;


BEGIN
 assign(f1, 'checkers.in'); reset(f1);
 assign(f2, 'checkers.out'); rewrite(f2);
 readln(f1, x);
 read(f1, n,m);
 if ((n+1)=m) then
  writeln(f2, 'Second')
  else
   writeln(f2, 'First');
 close(f1);
 close(f2);
end.