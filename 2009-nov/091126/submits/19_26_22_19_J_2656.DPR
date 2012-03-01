program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..100000]of integer;
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
end;            }

begin
  reset(input,'sort.in');
  rewrite(output,'sort.out');
  readln(n);
  for c:= 1 to n do
    read(a[c]);

{t := true;
while t=true do
  t := false; } 
for i:= 1 to n-1 do
  for j:= 1 to n-1 do
    if a[j] > a[j+1]then begin
      b:=a[j];
      a[j]:=a[j+1];
      a[j+1]:=b;
      //t := true;
      end;


for c:= 1 to n do
  write(a[c],' ');
end.
 