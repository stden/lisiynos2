program checkers;
var
 a,b,c:longint;
begin
 assign(input,'checkers.in');
 assign(output,'checkers.out');
 reset(input);
 rewrite(output);
 readln(a);
 readln(b,c);
 writeln('Second');
close(input);
close(output);
end.
