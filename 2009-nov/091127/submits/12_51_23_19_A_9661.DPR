program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
a:array[1..1001,0..1001]of boolean;
i,j,n,l,h,x,c:integer;
bl:boolean;
begin
reset(input, 'lego.in');
rewrite(output, 'lego.out');
readln(n);
h:=0;
for i:=1 to n do
  for j:=1 to n do
    a[i,j]:=false;
for i:=1 to n do a[i,0]:=true;

for i:=1 to n do begin
  readln(l,x);
  c:=n+1;
  repeat
    dec(c);
    bl:=false;


    for j:=x+1 to x+l do begin
      bl:=bl or a[j,c-1];
    end;

  until  bl=true;
  if c>h then h:=c;
  for j:= x+1 to x+l do begin
    a[j,c]:=true;
  end;

end;
write(h);

end.
 