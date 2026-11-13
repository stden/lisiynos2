program collection;
{$APPTYPE CONSOLE}
 var  a,b:array[1..100000] of int64;
   w,l,e,r,n,m,z:integer;
begin
l:=1;
reset(input,'collect.in');
read(n);
r:=n;
for z := 1 to n do
 read(a[z]);
read(m);
for z := 1 to m do
 read(b[z]);
rewrite(output,'collect.out');
z:=0;
e:=0;
while z<m do
   begin
   w:=0;
   z:=z+1;
   l:=1;
   r:=n;
   if (n=1)and (a[n]=b[z])  then
        writeln(1)
        else
    while l<=r do
     begin
       e:=(l+r) div 2;
        if (a[e]<b[z])  then l:=e+1
        else r:=e;
        if a[e]=b[z] then
        begin
        w:=w+1;
          writeln(1);
          break;
        end;
        if l=n then break;

     end;


     if w=0 then writeln(0);

   end;
end.
