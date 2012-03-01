{$N+}
program z;
var a1,a2,v1,v2:extended;
begin
 assign(input,'sun.in');
 reset(input);
 assign(output,'sun.out');
 rewrite(output);
 readln(v1,v2,a1,a2);
 writeln(abs((a1-a2)/(v1-v2)):0:10);
 readln;
End.