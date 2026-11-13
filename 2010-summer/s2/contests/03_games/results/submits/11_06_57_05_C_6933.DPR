program C;


begin
  assign(input,'chekers.in');
  assign(output,'chekers.out');
  reset(input);
  rewrite(output);
  writeln('First');
  close(input);
  close(output);

end.
