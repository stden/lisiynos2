program C;
var i,l,r,M,N:LongInt;
    a,b:array[1..100000] of int64;
    T:boolean;
begin
reset(input,'collect.in');
rewrite(output,'collect.out');
read(N);
for I := 1 to N do read(a[i]);
read(M);
for I := 1 to M do begin
read(b[i]);
l:=1;
r:=N;
T:=false;
if l=r then
  if a[1]=b[i] then writeln('1')
  else writeln('0')
else begin
while l<r do
begin
if a[(l+r) div 2]< b[i] then l:=(l+r) div 2+1
else r:=(l+r) div 2;
if a[l]=b[i] then begin
writeln('1');
T:=true;
break;
end;
end;
if not T then writeln('0')
end;
end;

end.
