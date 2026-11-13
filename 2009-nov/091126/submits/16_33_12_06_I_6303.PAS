program gai;
var a:array[1..100] of longint;
    i,x,imin,min,n:longint;
begin
 assign(input,'road.in');
 reset(input);
 assign(output,'road.out');
 rewrite(output);
 readln(n);
  for i:=1 to n do read(a[i]);
 readln(x);
 min:=100000;
  for i:=1 to n do
   if abs(x-a[i])<min then begin
                                min:=abs(x-a[i]);
                                imin:=i;
                           end;
 writeln(imin);
 readln;
End.