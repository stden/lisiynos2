program y;

{$APPTYPE CONSOLE}

uses
  SysUtils;

  var i,j:longint;
  a:string;
begin

reset(input,'y.in');
rewrite(output,'y.out');

read(a);

for i:= length(a) downto 1 do
write(a[i]);


 {
i:=1;
while not eoln do begin

inc(i);
end;

for j:=i downto 1 do
write(a[i]);
    }
end.
