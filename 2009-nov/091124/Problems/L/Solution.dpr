{$APPTYPE CONSOLE}
program task;
var
  i,n,k:integer;
  x,y,z,x1,y1,z1,r:extended;
begin
 assign(input,'flyfear.in');
 reset(input);
 assign(output,'flyfear.out');
 rewrite(output);
 readln(r);
 readln(x,y,z);
 readln(n);
 k:=0;
  for i:=1 to n do begin
   readln(x1,y1,z1);
    if sqr(x-x1)+sqr(y-y1)+sqr(z-z1)<sqr(r) then inc(k);
  end;
 writeln(k);
 readln;
End.


