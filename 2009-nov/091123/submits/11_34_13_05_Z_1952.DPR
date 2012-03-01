program z;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var a,b,s:longint;
begin
assign(input,'z.in');reset(input);
assign(output,'z.out');rewrite(output);
read(a,b);

s:=a+b;
write(s);

close(input);
close(output);
end.
 