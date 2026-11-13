program C;

var
 p,r,b,ch:longint;

begin
  assign(input,'checkers.in');
  assign(output,'checkers.out');
  rewrite(output);
  reset(input);
  readln(p);
  read(b,ch);
  r:=abs(b-ch);
  if r mod 2=0 then writeln('First')
   else writeln('Second');


close(input);
close(output);
end.
