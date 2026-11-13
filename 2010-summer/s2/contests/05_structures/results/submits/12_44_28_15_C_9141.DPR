program c ;
var f1,f2:text;
    i,j,n,m,q,l,r:integer;
    s: array [1..100000] of longint;
    t: array [1..100000] of integer;

begin
 assign(f1, 'collect.in'); reset(f1);
 assign(f2, 'collect.out'); rewrite(f2);
 readln(f1,n);
 for i:=1 to n do
  read(f1, s[i]);
 readln(f1, m);
 for i:=1 to m do
  read(f1, t[i]);
 for i:=1 to m do
  begin
   if n div 2 = 1 then
    q:=n div 2+1
     else q:=n div 2;
   r:=n;
   l:=1;
   if t[i]>s[q] then
    l:=q+1
     else r:=q;
   while l<r do
    begin
     if (r mod 2) = 1 then
      q:=(r-l) div 2+l
       else q:=(r-l) div 2+l;
     if s[q]<t[i] then
      l:=q+1
       else r:=q;
     end;
   if s[l]=t[i] then
    writeln (f2, '1')
     else writeln (f2, '0');
  end;
 close(f1);
 close(f2);
end.
