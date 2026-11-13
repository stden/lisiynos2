program b;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var i,a:integer;

     s:array [1..80] of int64;
begin
assign(input,'b.in');reset(input);
assign(output,'b.out');rewrite(output);
read(a);

s[1]:=1;
s[2]:=1;

for i:=3 to a do begin
s[i]:=s[i-1]+s[i-2];
end;
write(s[a]);

end.
