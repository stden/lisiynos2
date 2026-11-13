program C;

var
 m,r,l:longint;

begin
  assign(input,'checkers.in');
  assign(output,'checkers.out');
  rewrite(output);
  reset(input);
  readln(m);
  read(l,r);
  if l=r-1  then writeln('Second')
  else writeln('First');
close(input);
close(output);
end.
