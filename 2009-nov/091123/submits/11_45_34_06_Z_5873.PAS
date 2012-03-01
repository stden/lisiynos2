program z;
var a,b:longint;
begin
 assign(input,'z.in');
 reset(input);
 assign(output,'z.out');
 rewrite(output);
 readln(a,b);
 writeln(a+b);
 readln;
End.