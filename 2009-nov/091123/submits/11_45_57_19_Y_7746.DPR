program A;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
s1,s2:string;
i,n:integer;
begin
assign(input, 'y.in');
reset(input);
assign(output, 'y.out');
rewrite(output);

read(s1);
n:=length(s1);
for i:=0 to n-1 do
s2[i]:=s1[n-i];
write(s2);
end.
