{$APPTYPE CONSOLE}

var a : array[-1..100000] of longint;
    i,n,x,y,z,j,p,temp:longint;
begin
 assign(input,'time.in');
 reset(input);
 assign(output,'time.out');
 rewrite(output);
 read(n);
 for i:=1 to n do begin
   read(x,y,z);
   a[i]:=3600*x+60*y+z;
 end;
 for i:=1 to n do
   for j := i+1 to n do
     if a[i] > a[j] then begin
       temp := a[i];
       a[i] := a[j];
       a[j] := temp;
     end;
 for i:=1 to n do
   writeln(a[i] div 3600,' ',(a[i] div 60) mod 60,' ',a[i] mod 60);
 readln;
End.