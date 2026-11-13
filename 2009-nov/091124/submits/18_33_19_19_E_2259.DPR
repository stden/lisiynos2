program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
otv,a,b,x,y:real;
begin
assign(input, 'sun.in');
reset(input);
assign(output, 'sun.out');
rewrite(output);
readln(x,y,a,b);
otv:=(b-a)/(x-y);
writeln(otv:0:2);
end.
 