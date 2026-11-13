program b;
var f1,f2:text;
    a: array [1..100,1..100] of integer;
    n,i,j: integer;
    x:real;
begin
 x:=0;
 assign(f1, 'tree.in'); reset(f1);
 assign(f2, 'tree.out'); rewrite(f2);
 read(f1,n);
 for i:=1 to n do
  begin
   readln(f1);
   for j:=1 to n do
   begin
    read(f1, a[i,j]);
    if a[i,j]=1 then x:=x+1;
   end;
  end;
 x:=(x/2)+1;
 if n=x then writeln(f2, 'YES')
  else writeln(f2, 'NO');
 close(f1);
 close(f2);
end.