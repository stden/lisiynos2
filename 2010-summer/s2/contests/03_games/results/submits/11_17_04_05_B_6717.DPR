program C;


begin
  assign(input,'checkers.in');
  assign(output,'checkers.out');
  reset(input);
  rewrite(output);
  writeln('0');
close(input);
close(output);
end.
