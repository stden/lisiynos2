program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..100]of integer;  
i,j,n,r,b,c:integer;
begin
reset(input, 'road.in');
rewrite(output, 'road.out');
readln(n);
for i:= 1 to n do
  read(a[i]);
readln(r);

b:=9999999;
for i:= 1 to n do begin
if abs(r-a[i])<b then begin
  b:=abs(r-a[i]);
  c:=i;
end;

end;

writeln(c);

end.
 