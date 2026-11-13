program min;
{$APPTYPE CONSOLE}
 var posl:array[1..150000] of int64;
     n,q,l,r,minx,w,k:longint;
begin
reset(input,'interval.in');
rewrite(output,'interval.out');
read(n,k);
for q:= 1 to n  do
 read(posl[q]);
  r:=k-1;
  l:=0;
  while r<n do
     begin
     l:=l+1;
     r:=r+1;
     minx:=posl[l];
     q:=l-1;
     w:=0;
     while q<r do
   begin
   q:=q+1;
      if posl[q]<minx then
      begin
         w:=w+1;
       minx:=posl[q];
      end;
   end;
      if l<>n-k+1 then
          begin
      if w<>0 then writeln(minx);
      if w=0 then writeln(minx);
          end
        else
        begin
      if w<>0 then write(minx);
      if w=0 then write(minx);
        end;
       end;
end.
