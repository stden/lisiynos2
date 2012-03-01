program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
  n,i,j,count, min, min1:integer;
  a: array [1..100,1..100] of integer;
begin
  reset(input, 'unreal.in');
  rewrite(output, 'unreal.out');
  read(n);
  min:=0;
  min1:=1000000000;
  count:=0;
  for I := 1 to n do
  begin
    for j := 1 to n-1 do
    begin
      read(a[i,j]);
      min:=min + a[i,j];
      if j=n-1 then
      begin
        if min < min1 then
        begin
          min1:=min;
          min:=0;
          count:=i;
        end;
      end;
    end;
  end;
  write(count);
end.
