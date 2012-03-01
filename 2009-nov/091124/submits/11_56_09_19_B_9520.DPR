program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
a:array[1..100,1..100]of integer;
n,min,sum,c:int64;
i,j:integer;
begin
assign(input, 'unreal.in');
reset(input);
assign(output, 'unreal.out');
rewrite(output);

read(n);
c:=0;
min:=0;
for i:=1 to n do
  for j:= 1 to n-1 do
    read(a[i,j]);

  for j:= 1 to n-1 do
    min:=min+a[1,j];
  c:=1;

for i:=1 to n do begin
  sum:=0;
  for j:= 1 to n-1 do
    sum:=sum+a[i,j];
  if min>sum then begin
    min:=sum;
    writeln(sum);
    c:=i;
    end;
  end;


writeln(c);
end.
