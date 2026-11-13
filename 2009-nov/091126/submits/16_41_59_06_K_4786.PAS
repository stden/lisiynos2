program t;
var a:array[1..100] of longint;
    p,i,n,x,y,z,j,min,jmin:longint;
begin
 assign(input,'time.in');
 reset(input);
 assign(output,'time.out');
 rewrite(output);
 readln(n);
  for i:=1 to n do begin
   readln(x,y,z);
   a[i]:=3600*x+60*y+z;
  end;
  for i:=1 to n-1 do begin
  j:=i;
   min:=a[j];
   jmin:=j;
    for j:=i to n do
     if a[j]<min then begin
                           min:=a[j];
                           jmin:=j;
                      end;
   p:=a[i]; a[i]:=a[jmin]; a[jmin]:=p;
  end;
  for i:=1 to n do writeln(a[i] div 3600,' ',(a[i] div 60) mod 60,' ',a[i] mod 60);
 readln;
End.