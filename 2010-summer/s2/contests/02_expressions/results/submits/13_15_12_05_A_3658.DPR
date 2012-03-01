program A;

begin
  assign(input,'expr.in');
  assign(output,'expr.out');
  reset(input);
  rewrite(output);
 writeln('WRONG');
 close(input);
 close(input);
end.
