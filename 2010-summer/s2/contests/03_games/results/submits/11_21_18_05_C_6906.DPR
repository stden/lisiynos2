program C;


begin
  assign(input,'checkers.in');
  assign(output,'checkers.out');
  rewrite(output);
  writeln('First');
close(input);
close(output);
end.
