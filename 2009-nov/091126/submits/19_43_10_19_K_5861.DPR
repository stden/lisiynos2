program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..3,1..100000]of integer;
  c,n,b,i,j:integer;
  t:boolean;

{procedure qsort();
   procedure sort(l,r: integer);
     var i,j,x,y: integer;
   begin
     i := l;
     j := r;
     x := A[ (l + r) div 2 ];
     repeat
       while A[i] < x do inc(i);
       while x < A[j] do dec(j);
       if not (i>j) then
         begin
           y    := A[i];
           A[i] := A[j];
           A[j] := y;
           inc(i);
           dec(j);
         end;
     until i>j;
     if l < j then sort(l,j);
     if i < r then sort(i,r);
   end;
begin
 sort(0,High(A));
end;
 }

 
function Part(l, r,p: integer):integer;
var
v, i, j, b: integer;
begin
V:=a[p,r];
I:=l-1;
j:=r;
repeat
repeat
dec(j)
until (a[p,j]<=v) or (j=i+1);
repeat
inc(i)
until (a[p,i]>=v) or (i=j-1);
b:=a[p,i];
a[p,i]:=a[p,j];
a[p,j]:=b;
until i>=j;
a[p,j]:=a[p,i];
a[p,i]:= a[p,r];
a[p,r]:=b;
part:=i;
end;
procedure QuickSort(l, t,p: integer);
var i: integer;
begin
if l<t then
begin
i:=part(l, t,p);
QuickSort(l,i-1,p);
QuickSort(i+1,t,p);
end;
end;

begin
  reset(input,'time.in');
  rewrite(output,'time.out');
  readln(n);
  for c:= 1 to n do
    read(a[1,c],a[2,c],a[3,c]);


QuickSort(1,n,3);
QuickSort(1,n,2);
QuickSort(1,n,1);

{t := true;
while t=true do
  t := false;
for i:= 1 to n-1 do
  for j:= 1 to n-1 do
    if a[j] > a[j+1]then begin
      b:=a[j];
      a[j]:=a[j+1];
      a[j+1]:=b;
      //t := true;
      end;       }


for c:= 1 to n do
  writeln(a[1,c],' ',a[2,c],' ',a[3,c]);
end.



