var a:array[1..1000000] of longint;
    n,k:longint;
procedure QuickSort(L,R:longint);
var i,j,x,y:longint;
begin
  i:=l;
  j:= r;
  x:= a[(l+r)div 2];
  repeat
    while(A[i]<x)do inc(i);
    while(x< A[j])do dec(j);
    if (i<=j) then
    begin
      y:=A[i]; a[i]:=a[j]; a[j]:=y;
      inc(i); dec(j);
    end;
  until (i>j);
  if (l<j) then QuickSort(l,j);
  if (i<r) then QuickSort(i,r);
end;
begin
assign(input,'sort.in');
reset(input);
assign(output,'sort.out');
rewrite(output);
readln(k);
     for n:=1 to k do read(a[n]);
     QuickSort(1,k);
     for n:=1 to k do write(a[n],' ');
end.