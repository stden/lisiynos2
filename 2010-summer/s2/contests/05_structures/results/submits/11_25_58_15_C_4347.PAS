program a;
var f1,f2:text;
    i,j,n,m,q,l,r:integer;
    s: array [1..10000] of longint;
    t: array [1..10000] of integer;

begin
 assign(f1, 'collect.in'); reset(f1);
 assign(f2, 'collect.out'); rewrite(f2);
 readln(f1,n);
 for i:=1 to n do
  read(f1, s[i]);
 readln(f1, m);
 for i:=1 to n do
  read(f1, t[i]);
 q:=n div 2;
 r:=n;
 l:=1;
 for i:=1 to m do
  begin
   if t[i]>s[q] then
    l:=q+1
     else r:=q;
   while l<r do
    begin
     q:=(l*r) div 2 ;
     if s[q]<r then
      l:=q+1
       else r:=q;
     end;
   if s[l]=t[i] then
    writeln(f2, '1')
     else writeln(f2, '0');
  end;
 close(f1);
 close(f2);
end.
