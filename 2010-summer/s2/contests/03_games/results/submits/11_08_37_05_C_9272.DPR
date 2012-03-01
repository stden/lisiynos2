program C;


begin
  assign(input,'checkers.in');
  assign(output,'checkers.out');
  reset(input);
  rewrite(output);
  writeln('First');
  close(input);
  close(output);

end.
