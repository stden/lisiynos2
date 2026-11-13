program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
a:array[1..100,1..100]of integer;
i,n,j,min,sum,c:integer;
begin
assign(input, 'unreal.in');
reset(input);
assign(output, 'unreal.out');
rewrite(output);

read(n);
min:=999999999;
c:=0;
for i:=1 to n do begin
  sum:=0;
  for j:= 1 to n-1 do begin
    read(a[i,j]);
    sum:=sum+a[i,j];
  end;
  if min>sum then
    min:=sum;
    c:=i;
  end;

writeln(c);
{for i:=1 to n do
  for j:= 1 to n-1 do }



end.
 